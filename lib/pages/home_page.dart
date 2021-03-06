import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/public_controller.dart';
import '../model/home_menu_model.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../widgets/decoration.dart';
import '../widgets/home_menu_tile.dart';
import '../widgets/loading_widget.dart';
import 'change_password_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              body: _bodyUI(pc)
            ),
            if(pc.loading.value) const LoadingWidget()
          ],
        );
      }
    );
  }

  Widget _bodyUI(PublicController pc)=>SafeArea(
    child: Column(
      children: [
        ///AppBar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dSize(.04)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png',height: 45),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(color: const Color(0xffFF002D),fontSize: dSize(.045),fontWeight: FontWeight.w900),
                          children: const <TextSpan>[
                            TextSpan(text: 'Tashfia'),
                            TextSpan(text: ' Export', style: TextStyle(color: Colors.purple)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              PopupMenuButton<int>(
                key: _key,
                icon: Icon(LineAwesomeIcons.vertical_ellipsis,size: dSize(.07)),
                onSelected: (int val)async{
                  if(val==1){
                    Get.to(()=> ChangePasswordPage());
                  } else if(val==2){
                    await pc.logout();
                  }
                },
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(LineAwesomeIcons.key,color: AllColor.textColor,size: dSize(.06)),
                            SizedBox(width: dSize(.02)),
                            Text('?????????????????????????????? ???????????????????????? ????????????', style: StDecoration.normalTextStyle),
                          ],
                        ), value: 1,
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10),
                    ),

                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(LineAwesomeIcons.power_off,color: AllColor.textColor,size: dSize(.06)),
                          SizedBox(width: dSize(.02)),
                          Text('?????? ?????????', style: StDecoration.normalTextStyle),
                        ],
                      ), value: 2,
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10),
                    ),
                  ];
                },
                padding: const EdgeInsets.all(0.0),
                tooltip: '?????????????????? ???????????? ???????????????????????? ????????????',
                offset: Offset(0,dSize(.1)),
              ),
            ],
          ),
        ),

        Expanded(
          child: GridView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: dSize(.04),vertical: dSize(.02)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: dSize(.05),
              mainAxisSpacing: dSize(.05)),
            physics: const BouncingScrollPhysics(),
            children: HomeMenuModel.homeMenuDataList.map((element) => HomeMenuTile(model: element)).toList(),
          ),
        )
      ],
    ),
  );
}
