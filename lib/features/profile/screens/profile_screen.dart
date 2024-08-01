import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinamys/bloc/auth/auth_bloc.dart';
import 'package:tinamys/bloc/auth/auth_event.dart';
import 'package:tinamys/services/user/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _profile;
  late UserServices userServices;
  bool isExpanded = false;
  bool isMode = false;

  @override
  void initState() {
    super.initState();
    userServices = UserServices();
    fetchData();
  }

  Future<void> fetchData() async {
    dynamic response = await userServices.getUserProfile();
    setState(() {
      _profile = response['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerWidget(context),
            const SizedBox(
              height: 15,
            ),

            // working space
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Text(
                "Không gian làm việc",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _workingSpace(context),
            const SizedBox(
              height: 15,
            ),

            // settting space
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Text(
                "Cài đặt",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // setting colum
            _setting(context),

            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Phiên bản MYS v1.6.0",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/intro');
                },
                child: const Text(
                  'Được cung cấp bởi Tinasoft',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blueAccent,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // logout button
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(AuthenticationLogoutRequest());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ),
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                )
              )
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return _profile == null
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blueAccent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    _profile!['avatar']!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png?20200919003010",
                        width: 60.0,
                        height: 60.0,
                      );
                    },
                    width: 60.0,
                    height: 60.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_profile!['username']}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${_profile!['email']}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
  }

  // switch button
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  Widget buildIconSwitch(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: isMode,
      activeColor: Colors.red,
      onChanged: (bool value) {
        setState(() {
          isMode = value;
          // if (kDebugMode) {
          //   print(isMode);
          // }
        });
      },
      thumbIcon: thumbIcon,
    );
  }

  Widget buildSwitchChangeLanguague(BuildContext context) {
    return Container(
        color: Colors.black,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
        child: ListTile(
          iconColor: Colors.blueAccent,
          leading: const Icon(Icons.dark_mode),
          title: Text(
            'Chế độ ${isMode ? "sáng" : "tối"}',
          ),
          trailing: buildIconSwitch(context),
        ));
  }

  // sub menu for select language
  Widget buildListWithSubMenu(
      BuildContext context, IconData icon, String label) {
    return Container(
        color: Colors.black,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
        child: ExpansionTile(
          leading: Icon(
            icon,
            color: Colors.blueAccent,
          ),
          title: Text(label),
          trailing: Icon(
              isExpanded == false
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_up_outlined,
              color: Colors.white),
          onExpansionChanged: (bool expanding) =>
              setState(() => isExpanded = expanding),
          children: [
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("English"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Tiếng Việt"),
              trailing: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("中国"),
              onTap: () {},
            ),
          ],
        ));
  }

  Widget buildListTile(BuildContext context, IconData icon, String label) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      child: ListTile(
        iconColor: Colors.blueAccent,
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.white,
        ),
        onTap: () {

        },
      ),
    );
  }

  // change font of text in the app
  Widget buildChangeFontText(
      BuildContext context, IconData icon, String label) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      child: ListTile(
        iconColor: Colors.blueAccent,
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.white,
        ),
        onTap: () {
          showModalBottomSheet<void>(
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Text('Indie Flower', style: GoogleFonts.indieFlower(fontSize: 18),),
                      // Text('Open Sans', style: GoogleFonts.openSans(fontSize: 18), ),
                      // Text('Inter', style: GoogleFonts.inter(fontSize: 18), ),
                      // Text('NunitoSans', style: GoogleFonts.nunitoSans(fontSize: 18), ),
                      // Text('Poppins', style: GoogleFonts.poppins(fontSize: 18), )
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Indie Flower',
                            style: GoogleFonts.indieFlower(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Open Sans',
                            style: GoogleFonts.openSans(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Inter',
                            style: GoogleFonts.inter(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('NunitoSans',
                            style: GoogleFonts.nunitoSans(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Poppins',
                            style: GoogleFonts.poppins(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _workingSpace(BuildContext context) {
    return Column(
      children: <Widget>[
        buildListTile(context, Icons.work, 'Không gian làm việc'),
        buildListTile(context, Icons.home_work_outlined, 'Phòng ban'),
        buildListTile(context, Icons.person, 'Chức vụ'),
        buildListTile(context, Icons.person_add_alt_outlined, 'Nhân sự'),
        buildListTile(context, Icons.newspaper, 'Tin tức'),
        buildListTile(context, Icons.document_scanner_sharp, 'Document'),
      ],
    );
  }

  Widget _setting(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSwitchChangeLanguague(context),
        buildListWithSubMenu(context, Icons.language_outlined, "Ngôn ngữ"),
        buildListTile(context, Icons.code_outlined, 'Hướng dẫn sử dụng'),
        buildListTile(context, Icons.web_outlined, 'Trang web'),
        buildListTile(context, Icons.star_border_outlined, 'Đánh giá ứng dụng'),
        buildListTile(context, Icons.reply_outlined, 'Phản hồi'),
        buildListTile(context, Icons.sms_rounded, 'Liên hệ trợ giúp'),
        buildListTile(context, Icons.security_outlined, 'Điều khoản dịch vụ'),
        buildChangeFontText(context, Icons.settings, 'Cài đặt phông chữ'),
        buildListTile(
            context, Icons.person_remove_alt_1_outlined, 'Xóa tài khoản'),
      ],
    );
  }
}
