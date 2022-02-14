import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:numeric_converter/presentation/bloc/home_bloc.dart';
import 'package:numeric_converter/presentation/widgets/custom_button.dart';
import 'package:numeric_converter/presentation/widgets/custom_loaders.dart';
import 'package:numeric_converter/presentation/widgets/custom_snackbars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: kDancingLoader,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Numeric Converter',
            ),
          ),
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is ErrorState) {
                  setState(() {
                    context.loaderOverlay.hide();
                  });
                  buildErrorCustomSnackBar(context, state.message);
                }

                if (state is LoadingState) {
                  setState(() {
                    context.loaderOverlay.show();
                  });
                }

                if (state is InitialState) {
                  setState(() {
                    controller.text = '';
                    context.loaderOverlay.hide();
                  });
                }

                if (state is LoadedState) {
                  setState(() {
                    context.loaderOverlay.hide();
                  });
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is LoadedState) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'HEX:    ${state.hexAns}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'DEC:    ${state.decAns}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'OCT:    ${state.octalAns}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'BIN:    ${state.binaryAns}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const EmptyResult();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: controller,
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                labelText: 'Enter your task',
                                labelStyle: const TextStyle(
                                  color: Colors.purple,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.purple[300]!,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 3,
                                    color: Colors.purple,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    height: 50,
                                    body: const Text(
                                      'Reset',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onClick: () {
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(const HomeEventClear());
                                    },
                                    style: whiteButtonStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: CustomButton(
                                    height: 50,
                                    body: const Text('Calculate'),
                                    onClick: () {
                                      if (controller.text.isEmpty) {
                                        buildErrorCustomSnackBar(
                                          context,
                                          'Write you task!',
                                        );
                                        return;
                                      }
                                      BlocProvider.of<HomeBloc>(context).add(
                                        HomeEventCalculate(
                                          task: controller.text,
                                        ),
                                      );
                                    },
                                    style: purpleButtonStyle(),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyResult extends StatelessWidget {
  const EmptyResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'HEX:    NULL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'DEC:    NULL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'OCT:    NULL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'BIN:    NULL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
