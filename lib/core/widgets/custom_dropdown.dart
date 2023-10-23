import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

class CustomDropdown extends StatefulWidget {
  final String selectedText;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? textColor;
  final List<String> items;
  final IconData suffixIcon;
  final void Function(String?)? onChange;

  const CustomDropdown({
    Key? key,
    required this.selectedText,
    this.primaryColor,
    this.secondaryColor,
    this.textColor = Colors.white,
    required this.items,
    this.onChange,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late GlobalKey actionKey;
  late double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry? floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.selectedText);
    super.initState();
  }

  @override
  void dispose() {
    hideOverlay();
    super.dispose();
  }

  void hideOverlay() {
    if (floatingDropdown != null) {
      floatingDropdown!.remove();
      floatingDropdown = null;
    }
    isDropdownOpened = !isDropdownOpened;
  }

  void findDropdownData() {
    RenderBox renderBox =
        actionKey.currentContext?.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        height: 4 * height + 40,
        child: DropDown(
          selectedText: widget.selectedText,
          itemHeight: height,
          primaryColor: widget.primaryColor,
          secondaryColor: widget.secondaryColor,
          textColor: widget.textColor,
          items: widget.items,
          onChange: (value) {
            widget.onChange!(value);
            hideOverlay();
          },
        ),
      );
    });
  }

  void showDropDownOverlay() {
    findDropdownData();
    floatingDropdown = _createFloatingDropdown();
    Overlay.of(context).insert(floatingDropdown!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown!.remove();
          } else {
            showDropDownOverlay();
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.primaryColor,
          border: Border.all(
            color: LightTheme.primaryColorLightShade,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: <Widget>[
            Icon(widget.suffixIcon, color: LightTheme.primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.selectedText,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: LightTheme.primaryColor,
              // size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final double itemHeight;
  final Color? primaryColor;
  final Color? secondaryColor;
  final String selectedText;
  final Color? textColor;
  final List<String> items;
  final void Function(String)? onChange;

  const DropDown({
    Key? key,
    required this.itemHeight,
    this.textColor,
    required this.items,
    required this.selectedText,
    this.onChange,
    this.primaryColor,
    this.secondaryColor,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  late String selected = widget.selectedText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: const Alignment(-0.85, 0),
          child: ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              height: 20,
              width: 30,
              decoration: const BoxDecoration(
                color: LightTheme.primaryColor,
              ),
            ),
          ),
        ),
        Material(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: widget.primaryColor,
          child: Container(
            height: 2.8 * widget.itemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: LightTheme.primaryColorLightShade,
                width: 1,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: widget.items.map((item) {
                  return DropDownItem(
                    text: item,
                    isFirstItem: widget.items.first == item,
                    isLastItem: widget.items.last == item,
                    onChange: (value) {
                      widget.onChange!(value);
                      setState(() {
                        selected = value;
                      });
                    },
                    isSelected: selected == item,
                    primaryColor: widget.primaryColor,
                    secondaryColor: widget.secondaryColor,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final bool isFirstItem;
  final bool isLastItem;
  final bool isSelected;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? textColor;
  final void Function(String)? onChange;

  const DropDownItem({
    Key? key,
    required this.text,
    this.iconData,
    this.isFirstItem = false,
    this.isLastItem = false,
    this.primaryColor,
    this.secondaryColor,
    this.textColor = Colors.black,
    this.onChange,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange!(text);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: isFirstItem ? const Radius.circular(8) : Radius.zero,
            bottom: isLastItem ? const Radius.circular(8) : Radius.zero,
          ),
          color: isSelected ? secondaryColor : primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (iconData != null)
              Icon(
                iconData,
                color: textColor,
              ),
          ],
        ),
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}
