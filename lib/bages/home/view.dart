import 'package:flutter/material.dart';
import 'package:skillss/bages/formStart/view.dart';
import 'package:skillss/bages/jobs/view.dart';
import 'package:skillss/bages/workshop/view.dart';
import 'package:skillss/courses/view.dart';
import 'package:skillss/dataa.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SKILLS',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color: Colors.orange),
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('منصتنا الشاملة',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color: Colors.orange),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'مرحبًا بكم في منصتنا الشاملة للوظائف والدورات والورش!\n\n'
                                  'نحن نفتخر بتقديم بيئة مثيرة ومجتمع متميز يجمع بين أفضل الفرص الوظيفية والتدريب المتخصص في جميع المجالات. '
                                  'سواء كنت تبحث عن تطوير مهاراتك المهنية أو إعادة انطلاق مهني جديد، فإننا هنا لمساعدتك على تحقيق أهدافك.\n\n'
                                  ': فرص الوظائف\n'
                                  '\nنقدم مجموعة واسعة من فرص العمل المثيرة في مختلف القطاعات والمستويات الوظيفية. سواء كنت خريجًا طموحًا يبحث عن الانضمام إلى عالم العمل، أو محترف مخضرم يسعى للتطور والتحديات الجديدة، فإننا نقدم لك الفرصة المناسبة للتطور المهني والنجاح.\n'
                                  '\n:الدورات التدريبية\n'
                                  'نعلم أن التعلم المستمر هو المفتاح الرئيسي للنجاح في سوق العمل المتغير بسرعة. لذلك، نقدم مجموعة متنوعة من الدورات التدريبية المصممة خصيصًا لتلبية احتياجاتك الشخصية والمهنية. اختر من بين مجموعة متنوعة من المواضيع، بدءًا من التخصصات الفنية والتقنية وصولًا إلى المهارات الناعمة والقيادية\n'
                            '\nورش العمل:\n'
                                '\nتعتبر ورش العمل لدينا بيئة فعالة وتفاعلية لتطوير المهارات وتبادل المعرفة. سواء كنت ترغب في تعلم مهارات جديدة أو تعزيز المعرفة الحالية، فإن ورش العمل لدينا تضمن لك تجربة تعليمية عملية وممتعة.',
                            style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color: Colors.black),
                              textAlign: TextAlign.center,
                    ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text('إغلاق'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: const Color(0xff041038),
      ),

      drawer: Drawer(
        width: 200,
        backgroundColor:const Color(0xff041038) ,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('SKILLS SERVICES',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color:Colors.white ,fontFamily: "Cairo")),
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
            ),
              listText(context, 'الوظائف', Jobs()),
            listText(context, 'ورش ', workshop()),
            listText(context, 'دورات ', courses()),
            listText(context, 'خدماتنا', Home()),
            listText(context, 'سجل بيانتاتك', Home()),
            listText(context, 'تواصل معنا', Home()),
            // إضافة المزيد من عناصر القائمة حسب الحاجة
          ],
        ),
      ),
      backgroundColor: const Color(0xff041038),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: 1,
    itemBuilder: (BuildContext context, int i) {
        return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage(
                        "images/logo.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 10,
                          offset: Offset(0, 7),
                          color: Colors.black26
                      )
                    ],
                    //color: Colors.white
                  ),
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(20),
               child: RichText(
                 textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'انظم الى شبكتنا الواسعة',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          color: Colors.white,fontFamily: "Cairo"
                        ),
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: 'وابحث عن فرص',
                        style: TextStyle(fontFamily: "Poppins",
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.orange,
                        ),
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: 'وظيفية ودورات تدريبية',
                        style: TextStyle(fontFamily: "beINNormal",
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: 'مصممة خصيصا لتلبية احتياجاتك الشخصية والمهنية',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
             ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child:  Text('ابدأ رحلتك الان ',style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.white,
                    ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FormStart()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

          ],
        );
    }
          ),
        ),
      ),
    );
  }
}
