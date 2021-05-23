import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_list_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/activity_card.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/new_activity_form.dart';
import 'package:time_tracker_app/core/constants/constants.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Activity> list;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final state = Provider.of<ActivityListProvider>(context, listen: false);
    final stateL = Provider.of<ActivityListProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Time Tracker',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              try {
                await auth.signOut();
              } catch (e) {
                print(e);
                // TODO: show dialog
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBlackDark,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                height: 100,
                width: double.infinity,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Activities', style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: FutureBuilder(
                  future: stateL.getList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<Activity> list = snapshot.data as List<Activity>;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          itemBuilder: (context, index) => ActivityCard(
                            activity: list[index],
                            state: state,
                            index: index,
                          ),
                        );
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            clipBehavior: Clip.hardEdge,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            builder: (BuildContext context) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                child: NewActivityForm(state: stateL),
              );
            },
          );
          // stateL.addActivity(activity);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
