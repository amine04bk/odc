
Widget laun(String path, String name, String date, String description) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF5D6290),
      borderRadius: BorderRadius.circular(10),
    ),
    width: 600,

    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Image.asset(
                    path,
                    width: (140),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  SizedBox(height: 3),
                  Text(
                    date,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 35,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 104, 35, 35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
