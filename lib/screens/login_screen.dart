import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Icon(
                      Icons.photo_library_rounded,
                      size: 76,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.titleLarge, // Updated
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign in to continue',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge // Updated
                        ?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 26),
                  _LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, cur) => prev.status != cur.status,
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state.status == FormStatus.invalid) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Fix validation errors')));
        }
      },
      child: Column(
        children: [
          _EmailField(),
          const SizedBox(height: 12),
          _PasswordField(),
          const SizedBox(height: 18),
          _Actions(),
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextField(
        key: const Key('email'),
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: state.emailValid ? null : 'Enter a valid email',
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (v) => context.read<LoginBloc>().add(EmailChanged(v)),
      );
    });
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextField(
        key: const Key('password'),
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: state.passwordValid
              ? null
              : 'Password must be 8+ with upper, lower, number & symbol',
        ),
        obscureText: true,
        onChanged: (v) => context.read<LoginBloc>().add(PasswordChanged(v)),
      );
    });
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      final enabled = state.email.isNotEmpty &&
          state.password.isNotEmpty &&
          state.emailValid &&
          state.passwordValid;
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: enabled && state.status != FormStatus.submitting
                  ? () => context.read<LoginBloc>().add(LoginSubmitted())
                  : null,
              child: state.status == FormStatus.submitting
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('Sign in'),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/home'),
            child: const Text('Skip (demo)'),
          )
        ],
      );
    });
  }
}
