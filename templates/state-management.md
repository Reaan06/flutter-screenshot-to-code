---
name: state-management
description: State management templates for Flutter screens. Covers Riverpod, Bloc, Provider, and simple StatefulWidget patterns.
---

# State Management Templates

## Decision Guide

| Complexity | Recommendation | Dependencies |
|-----------|---------------|-------------|
| Single screen, no shared state | `StatefulWidget` | None |
| Single screen, form state | `StatefulWidget` + `Form` | None |
| 2-3 screens, simple shared state | `Provider` | provider |
| Medium app, many providers | `Riverpod` | flutter_riverpod |
| Complex events, many transitions | `BLoC` / `Cubit` | flutter_bloc, equatable |
| Quick prototype | `GetX` | get |
| Enterprise/team project | `Riverpod` or `BLoC` | Multiple |

---

## StatefulWidget (Default)

### Counter Example
```dart
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('$_count', style: Theme.of(context).textTheme.displayLarge),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => setState(() => _count--),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => setState(() => _count++),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
```

### Form State Example
```dart
class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Use _name and _email
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (v) => _name = v ?? '',
            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
          ),
          ElevatedButton(onPressed: _submit, child: const Text('Submit')),
        ],
      ),
    );
  }
}
```

---

## Provider

### Setup
```dart
// pubspec.yaml
dependencies:
  provider: ^6.1.0
```

### Theme Switcher Example
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

// Wire up in main.dart
MaterialApp(
  builder: (context, child) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            // ...
          );
        },
      ),
    );
  },
)

// Usage in settings
Consumer<ThemeProvider>(
  builder: (context, themeProvider, _) {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (v) {
        themeProvider.setThemeMode(v ? ThemeMode.dark : ThemeMode.light);
      },
    );
  },
)
```

### Shopping Cart Example
```dart
class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;
  double get total => _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// Usage
context.read<CartProvider>().addItem(item);
context.watch<CartProvider>().total;
```

---

## Riverpod

### Setup
```dart
// pubspec.yaml
dependencies:
  flutter_riverpod: ^2.5.0
```

### Provider Types

```dart
// Simple state
final counterProvider = StateProvider<int>((ref) => 0);

// State notifier (complex state)
final todosProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList();
});

// Future (async data)
final userProvider = FutureProvider<User>((ref) async {
  return ref.watch(authProvider).getUser();
});

// Stream
final messagesProvider = StreamProvider<List<Message>>((ref) {
  return ref.watch(chatProvider).messages;
});
```

### Complete Todo Example
```dart
// State
class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({required this.id, required this.title, this.completed = false});

  Todo copyWith({String? title, bool? completed}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

// Notifier
class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  void add(String title) {
    state = [...state, Todo(id: DateTime.now().toString(), title: title)];
  }

  void toggle(String id) {
    state = state.map((t) => t.id == id ? t.copyWith(completed: !t.completed) : t).toList();
  }

  void remove(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

// UI
class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final count = ref.watch(todosProvider.notifier).state.where((t) => !t.completed).length;

    return Scaffold(
      appBar: AppBar(title: Text('Todos ($count remaining)')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodo(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return CheckboxListTile(
            value: todo.completed,
            onChanged: (_) => ref.read(todosProvider.notifier).toggle(todo.id),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            secondary: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(todosProvider.notifier).remove(todo.id),
            ),
          );
        },
      ),
    );
  }

  void _addTodo(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(controller: controller, autofocus: true),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                ref.read(todosProvider.notifier).add(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
```

### Async Data Fetch
```dart
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('https://api.example.com/products'));
  final data = jsonDecode(response.body) as List;
  return data.map((e) => Product.fromJson(e)).toList();
});

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.invalidate(productsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price}'),
          ),
        ),
      ),
    );
  }
}
```

---

## BLoC / Cubit

### Setup
```dart
// pubspec.yaml
dependencies:
  flutter_bloc: ^8.1.0
  equatable: ^2.0.5
```

### Counter Cubit (Simple)
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}

// Usage
BlocProvider(
  create: (_) => CounterCubit(),
  child: BlocBuilder<CounterCubit, int>(
    builder: (context, count) {
      return Text('$count', style: Theme.of(context).textTheme.displayLarge);
    },
  ),
)
```

### Login BLoC (Events + States)
```dart
// Events
abstract class LoginEvent {}
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}

// States
abstract class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await authService.login(event.email, event.password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

// UI
BlocProvider(
  create: (context) => LoginBloc(authService: context.read<AuthService>()),
  child: BlocListener<LoginBloc, LoginState>(
    listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      }
    },
    child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return LoginForm(
          isLoading: state is LoginLoading,
          onSubmit: (email, password) {
            context.read<LoginBloc>().add(
              LoginSubmitted(email: email, password: password),
            );
          },
        );
      },
    ),
  ),
)
```

### Multi-BLoC Provider
```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => ThemeBloc()),
    BlocProvider(create: (_) => CartBloc()),
  ],
  child: MyApp(),
)
```
