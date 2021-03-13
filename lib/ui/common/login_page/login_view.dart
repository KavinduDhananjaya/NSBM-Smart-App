import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/common/login_page/login_page.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/round_button.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/util/assets.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static final log = Log("LoginView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  FocusNode _viewFocus;
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  CustomSnackBar _customSnackBar;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus?.dispose();
    _emailController.dispose();
    _passwordFocus?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Login View");

    final mediaData = MediaQuery.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    _customSnackBar = CustomSnackBar(scaffoldKey: scaffoldKey);

    void _loginClicked() {
      _customSnackBar.showLoadingSnackBar(
          backgroundColor: StyledColors.PRIMARY_COLOR);
      final email = (_emailController.text ?? "").trim();
      final password = (_passwordController.text ?? "").trim();
      if (email.isEmpty || password.isEmpty) {
        _customSnackBar.showErrorSnackBar("Email or Password is Empty!");
        return;
      }
      loginBloc.add(LoginClickEvent(email, password));
    }

    final emailField = TextFormField(
      textCapitalization: TextCapitalization.none,
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(labelText: "Email or ID"),
      onFieldSubmitted: (value) {
        _emailFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: !passwordVisible,
      focusNode: _passwordFocus,
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
        FocusScope.of(context).requestFocus(_viewFocus);
        _loginClicked();
      },
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: !passwordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );

    final scaffold = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(systemNavigationBarColor: Colors.blueGrey),
      child: Scaffold(
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: mediaData.size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                        ),
                        Image(
                          fit: BoxFit.fill,
                          height: 100,
                          image: AssetImage(Assets.LOGO_GRAPHIC),
                        ),
                        SizedBox(height: 24,),
                        Text(
                          "Smart App",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 2,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: StyledColors.DARK_BLUE,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        emailField,
                        SizedBox(
                          height: 16,
                        ),
                        passwordField,
                        SizedBox(
                          height: 16,
                        ),
                        RoundButton(
                          onClicked: _loginClicked,
                          text: "Login",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              _customSnackBar?.showErrorSnackBar(state.error);
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (pre, current) =>
          pre.email != current.email && current.email.isNotEmpty,
          listener: (context, state) {

            _customSnackBar.hideAll();
            rootBloc.add(UserLoggedEvent(state.email));
            log.d("Login successful.....");

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootView(
                  email: state.email,
                ),
              ),
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: scaffold,
      ),
    );
  }
}
