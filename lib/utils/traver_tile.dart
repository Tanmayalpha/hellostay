import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hellostay/constants/colors.dart';

class TravelDetailsTile extends StatefulWidget {
  @override
  _TravelDetailsTileState createState() => _TravelDetailsTileState();
}

class _TravelDetailsTileState extends State<TravelDetailsTile> {
  int adultCount = 1;
  int childrenCount = 0;
  List<List<int>> childrenAgesList = [];

  List<int?> childrenAgesSelected = [];
  List<List<int?>> childrenAgesSelectedList = [];
  List<int> adultCountList = [];
  List<int> childrenCountList = [];
  List<List<int?>> childrenCountListOfList = [];

  int? childrenAge;

  int room = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adultCountList.add(adultCount);
    childrenCountList.add(childrenCount);
    childrenCountListOfList.add(childrenAgesSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:
          Text('${adultCount + childrenCount} Travelers, $childrenCount Room'),
      children: [
        Wrap(
            children: List<Widget>.generate(room, (index) {
          return addRoom(index);
        })),
        Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            InkWell(
                onTap: () {
                  room++;
                  adultCountList.add(adultCount);
                  childrenCountList.add(childrenCount);
                  childrenCountListOfList.add(childrenAgesSelected);
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary)),
                  child: const Center(
                    child: Text(
                      'Add',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                )),
            const SizedBox(
              width: 100,
            ),
            InkWell(
                onTap: () {
                  room--;
                  adultCountList.removeLast();
                  childrenCountList.removeLast();
                  childrenCountListOfList.removeLast();
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary)),
                  child: const Center(
                    child: Text(
                      'Remove',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }

  Widget _buildChildrenDropdowns(int index) {
    return Wrap(
      children: List<Widget>.generate(childrenCountList[index], (i) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton2<int>(
            underline: const SizedBox(),
            isDense: true,
            hint: const Text('Age'),
            value: childrenCountListOfList[index][i],
            onChanged: (value) {
              setState(() {
                // childrenAgesSelected[i] = value;
                childrenCountListOfList[index][i] = value;
              });
            },
            items: List.generate(18, (index) => index + 1)
                .map((age) => DropdownMenuItem<int>(
                      value: age,
                      child: Text('$age'),
                    ))
                .toList(),
          ),
        );
      }),
    );
  }

  Widget _buildIncrementDecrement(
      String label, int count, Function(int) onChanged) {
    return Column(
      children: [
        Text(label),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.faqanswerColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(

                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),


                    icon: const Icon(Icons.remove,),
                    onPressed: () {
                      if (count > 0) {
                        onChanged(count - 1);
                        childrenAgesSelected.removeLast();
                        // _updateChildrenAgesList();
                      }
                    },
                  ),
                ),
              ),
              Container(
                color: AppColors.faqanswerColor.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 12),
                  child: Text('$count')),
              SizedBox(
                height: 30,
                width:30,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),

                  icon: const Icon(Icons.add),
                  onPressed: () {
                    childrenAgesSelected.add(childrenAge);

                    onChanged(count + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addRoom(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIncrementDecrement('Adults', adultCountList[index], (value) {
              setState(() {
                adultCountList[index] = value;
                //adultCount = value;
              });
            }),
            _buildIncrementDecrement('Children', childrenCountList[index],
                (value) {
              setState(() {
                childrenCountList[index] = value;
                //  childrenCount = value;
              });
            }),
          ],
        ),
        if (childrenCountList[index] > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              childrenCountList[index] > 1
                  ? const Text('Age of Children')
                  : Text('Age of Child'),
              _buildChildrenDropdowns(index),
            ],
          ),
      ],
    );
  }
}
