import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numeric_converter/presentation/cubit/home_cubit.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          return state.when(
            initialState: () => const EmptyScreen(),
            loadingState: () => const EmptyScreen(),
            loadedState: (List<String>? strings) {
              return strings != null
                  ? ListView.builder(
                      itemCount: strings!.length,
                      itemBuilder: (context, index) {
                        return Text(strings[index]);
                      },
                    )
                  : Container(
                      color: Colors.red,
                    );
            },
            errorState: (String message, int? statusCode) =>
                const EmptyScreen(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<HomeCubit>(context).changeArray();
        },
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
