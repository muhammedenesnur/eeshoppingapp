import 'package:eshopping/model/onboarding_model.dart';
import 'package:eshopping/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  PageController? _controller;
  int currentIndex = 0;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    List<UnBoardingModel> contents = [
      UnBoardingModel(
        title: AppLocalizations.of(context)!.onboardTitleOne,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuPARkl9jmy9a_n7U8MJd7klZFKWrtc5pilQ&s',
        description: AppLocalizations.of(context)!.onboardDescOne,
      ),
      UnBoardingModel(
        title: AppLocalizations.of(context)!.onboardTitleTwo,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUzmXhy1hI7yDn9atoYqniFMhnrBabav68DQ&s',
        description: AppLocalizations.of(context)!.onboardDescTwo,
      ),
      UnBoardingModel(
        title: AppLocalizations.of(context)!.onboardTitleThree,
        image:
            'https://cdni.iconscout.com/illustration/premium/thumb/bill-payment-2357775-2016223.png',
        description: AppLocalizations.of(context)!.onboardDescThree,
      ),
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image(
                          height: ScreenUtil().setHeight(250),
                          image: NetworkImage(contents[i].image),
                        ),
                        Text(
                          contents[i].title,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            contents[i].description)
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    contents.length, (index) => buildDot(index, context))
              ],
            ),
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: EdgeInsets.all(40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: Text(
                AppLocalizations.of(context)!.next,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                }
                _controller?.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
