import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Veterinary extends StatelessWidget {
  final List<Map<String, String>> links = [
    {
      'name': 'Vet For You',
      'url':
          'https://www.google.com/search?q=Vet+or+you&tbm=lcl&sxsrf=AJOqlzVrA-J0yv0Vqr1-1vLi3rEmgCKy7Q%3A1677635387910&ei=O6_-Y9uUN9bw4-EP1a2dgAU&ved=0ahUKEwibnu_qzrn9AhVW-DgGHdVWB1AQ4dUDCAk&uact=5&oq=Vet+or+you&gs_lcp=Cg1nd3Mtd2l6LWxvY2FsEAMyBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjoECCMQJzoFCAAQkQI6CwgAEIAEELEDEIMBOggIABCABBCxAzoICAAQsQMQgwE6BAgAEEM6CggAELEDEIMBEEM6BwgAEMkDEEM6BQgAEJIDOggIABCABBCSAzoFCAAQgAQ6CggAEIAEEBQQhwJQAFjwFmCkGWgAcAB4AIABrAGIAawMkgEEMC4xMJgBAKABAcABAQ&sclient=gws-wiz-local#rlfi=hd:;si:4503408657182793396,l,CgpWZXQgb3IgeW91SNrX36Csj4CACFoWEAAQARACGAAYAiIKdmV0IG9yIHlvdZIBD2FuaW1hbF9ob3NwaXRhbJoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VSRE1tTlBNRVJuRUFFqgESEAEqDiIKdmV0IG9yIHlvdSgA;mv:[[27.7471948,85.5326463],[27.623801999999998,85.2781183]]'
    },
    {
      'name': 'City House And Animal Clinic',
      'url':
          'https://www.google.com/search?q=City+house+and+animal+clinic&tbm=lcl&sxsrf=AJOqlzXmpTNCa7wVpltchOdvspiI_gF6BA%3A1677635309711&ei=7a7-Y_yUK7St4-EPkZe_gA0&ved=0ahUKEwi8v8rFzrn9AhW01jgGHZHLD9AQ4dUDCAk&uact=5&oq=City+house+and+animal+clinic&gs_lcp=Cg1nd3Mtd2l6LWxvY2FsEAMyBggAEBYQHjoECCMQJzoCCCY6BwgjEOoCECc6BQgAEJECOgsIABCABBCxAxCDAToICAAQsQMQgwE6CwgAELEDEIMBEJECOggIABCABBCxAzoFCAAQgAQ6BAgAEEM6EAgAEIAEEBQQhwIQsQMQgwE6CAgAEIAEEMkDOgUIABCSAzoKCAAQgAQQFBCHAjoHCAAQgAQQCjoICAAQFhAeEA86BQghEKABOggIIRAWEB4QHToKCCEQFhAeEA8QHToFCAAQhgNQOFjhTmC6UGgCcAB4BIAB0gGIAYkukgEGMC4zNC4xmAEAoAEBsAEKwAEB&sclient=gws-wiz-local#rlfi=hd:;si:6422093667010735909,a;mv:[[27.720198977319022,85.36640611109857],[27.71983902268097,85.36599948890144]]'
    },
    {
      'name': 'VAANS Veterinary Hospital',
      'url':
          'https://www.google.com/search?q=VAANS+veterinary+hospital&tbm=lcl&sxsrf=AJOqlzWqTbyi294PypdtJbuY4Xd8DD_5Aw%3A1677635142064&ei=Rq7-Y9HEA9je4-EPks-XsA4&ved=0ahUKEwjR_9H1zbn9AhVY7zgGHZLnBeYQ4dUDCAk&uact=5&oq=VAANS+veterinary+hospital&gs_lcp=Cg1nd3Mtd2l6LWxvY2FsEAMyAggmOgcIIxDqAhAnOgQIIxAnOgQIABBDOgsIABCABBCxAxCDAToICAAQgAQQsQM6BQgAEIAEOggIABCxAxCDAToKCAAQsQMQgwEQQzoHCAAQsQMQQzoHCAAQAxCLAzoOCAAQgAQQsQMQgwEQiwM6CAgAEIAEEIsDOgcIABCABBAKOgcIABANEIAEOgYIABAeEA06CAgAEB4QDRAKOggIABAFEB4QDToICAAQCBAeEA06BQgAEIYDOgYIABAWEB5QkQ9YulBg4FJoAXAAeACAAc0BiAGdIZIBBjAuMjQuMZgBAKABAbABCrgBAsABAQ&sclient=gws-wiz-local#rlfi=hd:;si:2060975230019773416,l,ChlWQUFOUyB2ZXRlcmluYXJ5IGhvc3BpdGFsSJWv_fKxt4CACFoxEAAQARACGAAYARgCIhl2YWFucyB2ZXRlcmluYXJ5IGhvc3BpdGFsKggIAhAAEAEQApIBD2FuaW1hbF9ob3NwaXRhbA;mv:[[27.721894977319025,85.37851831426099],[27.721535022680968,85.378111685739]]'
    },
    {
      'name': 'Advanced Pet Hospital',
      'url':
          'https://www.google.com/search?q=advanced+pet+hospital&tbm=lcl&sxsrf=AJOqlzV8FyirEZ6Komxlf1wSNs9pjz4wfw%3A1677635449377&ei=ea_-Y8_QFomU4-EP5Oq0wA4&oq=Advanced+&gs_lcp=Cg1nd3Mtd2l6LWxvY2FsEAEYADIFCAAQkQIyBQgAEJECMgUIABCABDIKCAAQgAQQsQMQCjIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoECCMQJzoECAAQQzoKCAAQsQMQgwEQQzoLCAAQgAQQsQMQgwE6CAgAEIAEELEDOggIABCxAxCDAToLCAAQsQMQgwEQkQI6CAgAEIAEEIsDOgoIABCABBAUEIcCOg4IABCABBCxAxCDARCLAzoNCAAQgAQQsQMQsQMQClAAWNwQYModaABwAHgAgAHPAYgB1AySAQUwLjcuMpgBAKABAbgBAsABAQ&sclient=gws-wiz-local'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(191, 134, 143, 30),
        title: Text(
          'Available Veterinary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: links.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(links[index]['name']!),
            onTap: () => launch(links[index]['url']!),
          );
        },
      ),
    );
  }
}
