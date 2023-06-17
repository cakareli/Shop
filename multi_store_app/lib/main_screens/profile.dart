import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens.dart/orders.dart';
import 'package:multi_store_app/customer_screens.dart/wishlist.dart';
import 'package:multi_store_app/main_screens/cart.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.brown],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                centerTitle: true,
                elevation: 0,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        child: const Text('Account'),
                      ),
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.brown],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 25),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('images/inapp/guest.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  'guest'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50)),
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(),
                                    ));
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Center(
                                  child: Text(
                                    'Orders',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerOrdersScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Wishlist',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerWishlistScreen(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                            child: Image(
                                image: AssetImage('images/inapp/logo.jpg')),
                          ),
                          const ProfileHeaderLabel(headerLabel: 'Account Info'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: const [
                                  RepeatedListTile(
                                    title: 'Email Address',
                                    subtitle: 'example@email.com',
                                    icon: Icons.email,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.yellow,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  RepeatedListTile(
                                    title: 'Phone Number',
                                    subtitle: '+11111',
                                    icon: Icons.phone,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.yellow,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  RepeatedListTile(
                                    title: 'Address',
                                    subtitle: 'example adress',
                                    icon: Icons.location_pin,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const ProfileHeaderLabel(
                              headerLabel: 'Account Settings'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  RepeatedListTile(
                                    title: 'Edit Profile',
                                    subtitle: '',
                                    icon: Icons.edit,
                                    onPressed: () {},
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.yellow,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  RepeatedListTile(
                                    title: 'Change Password',
                                    subtitle: '',
                                    icon: Icons.lock,
                                    onPressed: () {},
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.yellow,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  RepeatedListTile(
                                    title: 'Log out',
                                    subtitle: '',
                                    icon: Icons.logout,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/welcome_screen');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    required this.headerLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
