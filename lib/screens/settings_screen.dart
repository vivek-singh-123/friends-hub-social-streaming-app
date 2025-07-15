import 'package:flutter/material.dart';
import 'package:gosh_app/screens/legal_text_screen.dart'; // ✅ Reusable screen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _hideFavorites = false;
  bool _hideLikes = false;
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            _buildSwitchTile('Notifications', _notificationsEnabled,
                    (val) => setState(() => _notificationsEnabled = val)),
          ]),

          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text('Privacy Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          ),
          _buildCard([
            _buildSwitchTile('Hide my favorites', _hideFavorites,
                    (val) => setState(() => _hideFavorites = val)),
            _buildSwitchTile('Hide my likes', _hideLikes,
                    (val) => setState(() => _hideLikes = val)),
          ]),

          const SizedBox(height: 12),
          _buildCard([
            _buildListTile('Privilege Setting', onTap: () {}),
            _buildListTile('Blacklist', onTap: () {}),
          ]),

          const SizedBox(height: 12),
          _buildCard([
            ListTile(
              title: const Text('Clear Cache'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              ),
              trailing: const Icon(Icons.delete_outline, color: Colors.grey),
            ),
          ]),

          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text('About Us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          ),
          _buildCard([
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Icon(Icons.live_tv, size: 60, color: Colors.deepPurple),
                    SizedBox(height: 6),
                    Text('Friends HUB v1.0.0', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ]),

          const SizedBox(height: 12),
          _buildCard([
            _buildListTile('Terms and Conditions', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalTextScreen(
                    title: 'Terms & Conditions',
                    content: termsContent,
                  ),
                ),
              );
            }),
            _buildListTile('Privacy Policy', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalTextScreen(
                    title: 'Privacy Policy',
                    content: privacyContent,
                  ),
                ),
              );
            }),
          ]),

          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text('Feedback',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          ),
          _buildCard([
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _selectedRating = index + 1),
                );
              }),
            )
          ]),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.deepPurple,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildListTile(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }
}

// Full Terms & Conditions
const String termsContent = '''
                                        <h1>Terms & Conditions</h1>
</br>
Welcome to GOSH!
</br>
</br>
</br>
</br>
We've drafted these Terms of Service (which we simply call the "Terms") so that you'll know the rules that govern our relationship with you. Although we have tried our best to strip the legalese from the Terms, there are places where these Terms may still read like a traditional contract. There's a good reason for that: These Terms do indeed form a legally binding contract between you and Gosh Streaming PTY LTD. So please read them carefully.
</br>
</br>
</br>


By using the Services, you agree to the Terms. Of course, if you don't agree with them, then don't use the Services.


The following Terms of Service outline your obligations when using our mobile application (“App”) or Service (as defined herein), or any of the information, text, graphics, videos, or other files, materials, data or content of any kind whatsoever created or provided by or through the App or the Service or through your ability to sell products on the App and generate User Contributed Content (as defined herein). Please also review our Privacy Policy, which is a part of these Terms of Service and which outlines our practices towards handling any personal information that you may provide to us.


The App and the Service are owned and operated by Gosh Streaming PTY LTD. (“Gosh,” “we,” or “us”) and are accessed by you under the Terms of Service described herein (“Terms of Service” or “Agreement”). Please read these Terms of Service carefully before using the App or the Service. By accessing the App or using any part of the Service, you agree to become bound by these terms and conditions. If you do not agree to all these terms and conditions, then you may not access the App or use the Service. Nothing in this Agreement shall be deemed to confer any third party rights or benefits.


<h5>1. Who Can Use the Services</h5>
No one under 18 is allowed to create an account or use the Services. We may offer additional Services with additional terms that may require you to be even older to use them. So please read all terms carefully.

By using the Services, you state that:

You can form a binding contract with Gosh;
You will comply with these Terms and all applicable local, state, national, and international laws, rules, and regulations.
If you are using the Services on behalf of a business or some other entity, you state that you are authorized to grant all licenses set forth in these Terms and to agree to these Terms on behalf of the business or entity.

No one under 18 is allowed to create an account or use the Services.

You hereby warrant that you are at least 18 years old. In the event that the information you provide in this regard is not truthful, Gosh shall not be liable as it cannot verify the age of its users. If you are under 18 years old, do not attempt to register or use the App or the Service. If you are under the age of 18, you may use the Service, with or without registering, only with the approval of your parent or guardian. In addition, you should review these terms with your parent or guardian to make sure that you and your parent or guardian understand and agree with these terms.

</br>
<h5>2. Rights We Grant You</h5>
Gosh grants you a personal, worldwide, royalty-free, non-assignable, nonexclusive, revocable, and non-sublicensable license to access and use the Services. This license is for the sole purpose of letting you use and enjoy the Service's benefits in a way that these Terms and our usage policies.

Any software that we provide you may automatically download and install upgrades, updates, or other new features. You may be able to adjust these automatic downloads through your device's settings.

You may not copy, modify, distribute, sell, or lease any part of our Services, nor may you reverse engineer or attempt to extract the source code of that software, unless applicable laws prohibit these restrictions or you have our written permission to do so.

</br>
<h5>3. Rights You Grant Us</h5>
Many of our Services let you create, upload, post, send, receive, and store content. When you do that, you retain whatever ownership rights in that content you had to begin with. But you grant us a license to use that content. How broad that license is depends on which Services you use and the Settings you have selected.

For all Services, you grant Gosh a worldwide, royalty-free, sublicensable, and transferable license to host, store, use, display, reproduce, modify, adapt, edit, publish, and distribute that content. This license is for the limited purpose of operating, developing, providing, promoting, and improving the Services and researching and developing new ones.

Because Local is inherently public and chronicle matters of public interest, the license you grant us for content submitted to those Services is broader. In addition to the rights you grant us in connection with other Services, you also grant us a perpetual license to create derivative works from, promote, exhibit, broadcast, syndicate, publicly perform, and publicly display content submitted to Local or any other crowd-sourced Services in any form and in any and all media or distribution methods (now known or later developed). To the extent it's necessary, you also grant Gosh and our business partners the unrestricted, worldwide, perpetual right and license to use your name, likeness, Local content that you upload or send. This means, among other things, that you will not be entitled to any compensation from Gosh or our business partners if your name, likeness or Local.

While we're not required to do so, we may access, review, screen, and delete your content at any time and for any reason, including if we think your content violates these Terms. You alone though remain responsible for the content you create, upload, post, send, or store through the Service.

The Services may contain advertisements. In consideration for Gosh letting you access and use the Services, you agree that Gosh, its affiliates, and third-party partners may place advertising on the Services.

We always love to hear from our users. But if you volunteer feedback or suggestions, just know that we can use your ideas without compensating you.

You agree to receive emails or text messages about its management and operation sent by this website.

</br>
<h5>4. The Content of Others</h5>
Much of the content on our Services is produced by users, publishers, and other third parties. Whether that content is posted publicly or sent privately, the content is the sole responsibility of the person or organization that submitted it. Although Gosh reserves the right to review all content that appears on the Services and to remove any content that violates these Terms, we do not necessarily review all of it. So we cannot—and do not—take responsibility for any content that others provide through the Services.

Through these Terms, we make clear that we do not want the Services put to bad uses. But because we do not review all content, we cannot guarantee that content on the Services will always conform to our Terms.

We do not endorse, support, represent or guarantee the truthfulness, accuracy, or reliability of any content contributed by users or endorse any of the opinions expressed therein. You agree to waive, and hereby do waive, any legal or equitable rights or remedies you have or may have against us with respect thereto. You acknowledge that any reliance on User Contributed Content of any Gosh user will be at your own risk.

</br>
<h5>5. Privacy</h5>
Your privacy matters to us. You can learn how we handle your information when you use our Services by reading our privacy policy. We encourage you to give the privacy policy a careful look because, by using our Services, you agree that Gosh can collect, use, and transfer your information consistent with that policy.

</br>
<h5>6. Respecting Other People's Rights</h5>
Gosh respects the rights of others. And so should you. You therefore may not upload, send, or store content that:

violates or infringes someone else's rights of publicity, privacy, copyright, trademark, or other intellectual-property right;
bullies, harasses, or intimidates;
defames, or spams or solicits Gosh's users;
is inappropriate to other users or illegal, including, but not limited to, anything that is defamatory, inaccurate, unlawful, harmful, threatening, abusive, harassing, vulgar, offensive, obscene, pornographic, hateful, or promotes violence, discrimination, bigotry, racism, or hatred, as determined by Gosh in its sole discretion;
introduces viruses, time-bombs, worms, cancelbots, Trojan horses and/or other harmful code, - is reverse look-up or trace any information of any other User or visitor or otherwise use the Services for the purpose of obtaining information of any User or visitor;
attempts to gain unauthorized access to any portion of the Services, or any systems or networks by hacking, password "mining" or any other illegitimate means;
uses any "deep-link", "page-scrape", "robot", "spider" or other automatic device, program, algorithm or methodology, or any manual process to access, acquire, copy or monitor any portion of the Services or any data or materials contained therein or obtain or attempt to obtain any materials, documents or information through any means not purposely made available through the System;
asks or offers sexually explicit images or engage in any activity harmful to minors or otherwise violates these terms.
You must also respect Gosh's rights. These Terms do not grant you any right to:

use branding, logos, designs, photographs, videos, or any other materials used in our Services;
copy, archive, download, upload, distribute, syndicate, broadcast, perform, display, make available, or otherwise use any portion of the Services or the content on the Services except as set forth in these Terms;
use the Services or any content on the Services for any commercial purposes without our consent.
In short: You may not use the Services or the content on the Services in ways that are not authorized by these Terms. Nor may you help or enable anyone else in doing so.

We reserve the right at all times (but will not have an obligation) to remove or refuse to distribute any content contributed by Gosh users, such as content which violates these Terms of Service. We also reserve the right to access, read, preserve, and disclose any information as we reasonably believe is necessary to:

satisfy any applicable law, regulation, legal process or governmental request;
enforce these Terms of Service, including investigation of potential violations hereof;
detect, prevent, or otherwise address fraud, security or technical issues;
respond to member support requests, or protect our rights, property or safety, and that of our users and the public.
We will not be responsible or liable for the exercise or non-exercise of this right under these Terms of Service.

You understand that by using or accessing the App or the Service you may be exposed to content that might be offensive, harmful, inaccurate or otherwise inappropriate material, or in some cases, postings that have been mislabeled or are otherwise deceptive. Under no circumstances will we be liable in any way for any content or communications, including, but not limited to, any errors or omissions in any form of User Contributed Content, or any loss or damage of any kind incurred as a result of the use of any Gosh content or content posted by users which are posted, emailed, transmitted or otherwise made available on the App or through the Service.

</br>
<h5>7. Respecting Copyright</h5>
You agree to only upload, post, submit or otherwise transmit User Contributed Content:

that you have the lawful right to use, copy, distribute, transmit, or display;
that does not infringe the intellectual property rights or violate the privacy rights of any third party (including, without limitation, copyright, trademark, patent, trade secret, or other intellectual property right, or moral right or right of publicity). Gosh respects the legal rights of others, and asks that its users do the same.
Gosh honors the requirements set forth in the Digital Millennium Copyright Act. We therefore take reasonable steps to expeditiously remove from our Services any infringing material that we become aware of. And if Gosh becomes aware that one of its users has repeatedly infringed copyrights, we will take reasonable steps within our power to terminate the user's account.

We make it easy for you to report suspected copyright infringement. If you believe that anything on the Services infringes a copyright that you own or control, please fill out this form. Or you may file a notice with us:  support@gosh.com

If you file a notice with our Copyright Agent, must:

contain the physical or electronic signature of a person authorized to act on behalf of the copyright owner;
identify the copyrighted work claimed to have been infringed;
identify the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed, or access to which is to be disabled, and information reasonably sufficient to let us locate the material;
provide your contact information, including your address, telephone number, and an email address;
provide a personal statement that you have a good-faith belief that the use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and
provide a statement that the information in the notification is accurate and, under penalty of perjury, that you are authorized to act on behalf of the copyright owner.
</br>
<h5>8. Safety</h5>
We try hard to keep our Services a safe place for all users. But we cannot guarantee it. That's where you come in. By using the Services, you agree that:

You will not use the Services for any purpose that is illegal or prohibited in these Terms.
You will not use any robot, spider, crawler, scraper, or other automated means or interface to access the Services or extract other user's information.
You will not use or develop any third-party applications that interact with the Services or other users' content or information without our written consent.
You will not use the Services in a way that could interfere with, disrupt, negatively affect, or inhibit other users from fully enjoying the Services, or that could damage, disable, overburden, or impair the functioning of the Services.
You will not use or attempt to use another user's account, username, or password without their permission.
You will not solicit login credentials from another user.
You will not post content that contains pornography, graphic violence, threats, hate speech, guns or other weaponry, or incitements to violence.
You will not upload viruses or other malicious code or otherwise compromise the security of the Services.
You will not attempt to circumvent any content-filtering techniques we employ, or attempt to access areas or features of the Services that you are not authorized to access.
You will not probe, scan, or test the vulnerability of our Services or any system or network.
You will not encourage or promote any activity that violates these Terms.
We have the right to investigate and prosecute violations of any of the above, including intellectual property rights infringement and App security issues, to the fullest extent of the law. We may involve and cooperate with law enforcement authorities in prosecuting Gosh users who violate these Terms of Service. You acknowledge that we have the right to monitor your access to or use of the App and/or the Service for operating purposes, to ensure your compliance with these Terms of Service, or to comply with applicable law or the order or requirement of a court, administrative agency or other governmental body.

We also care about your safety while using our Services. So do not use our Services in a way that would distract you from obeying traffic or safety laws. And never put yourself or others in harm's way.

</br>
<h5>9. Your Account</h5>
You are responsible for any activity that occurs in your account. So it's important that you keep your account secure. One way to do that is to select a strong password that you don't use for any other account.

By using the Services, you agree that, in addition to exercising common sense:

You will not create more than one account for yourself.
You will not create another account if we have already disabled your account, unless you have our written permission to do so.
You will not buy, sell, rent, or lease access to your Gosh account without our written permission.
You will not share your password.
You will not log in or attempt to access the Services through unauthorized third-party applications or clients.
If you think that someone has gained access to your account, please immediately reach out to Gosh Support at: support@gosh.com

</br>
<h5>10. Data Charges and Mobile Phones</h5>
You are responsible for any mobile charges that you may incur for using our Services, including text-messaging and data charges. If you're unsure what those charges may be, you should ask your service provider before using the Services.

</br>
<h5>11. Third-Party Services</h5>
If you use a service, feature, or functionality that is operated by a third party and made available through our Services (including Services we jointly offer with the third party), each party's terms will govern the respective party's relationship with you. Gosh is not responsible or liable for those third party's terms or actions taken under the third.

</br>
<h5>12. Modifying the Services and Termination</h5>
We're relentlessly improving our Services and creating new ones all the time. That means we may add or remove features, products, or functionalities, and we may also suspend or stop the Services altogether. We may take any of these actions at any time, and when we do, we may not provide you with any notice beforehand.

Gosh may also terminate these Terms with you at any time, for any reason, and without advanced notice. That means that we may stop providing you with any Services, or impose new or additional limits on your ability to use the Services. For example, we may deactivate your account due to prolonged inactivity or inappropriate behavior, and we may reclaim your username at any time for any reason.

</br>
<h5>13. Indemnity</h5>
You agree, to the extent permitted under applicable law, to indemnify, defend, and hold harmless Gosh, our directors, officers, employees, and affiliates from and against any and all complaints, charges, claims, damages, losses, costs, liabilities, and expenses (including attorneys' fees) due to, arising out of, or relating in any way to:

your access to or use of the Services;
your content;
your breach of these Terms.
</br>
<h5>14. Disclaimers</h5>
We try to keep the Services up and running and free of annoyances. But we make no promises that we will succeed.

The services are provided "as is" and "as available" and to the extent permitted by applicable law without warranties of any kind, either express or implied, including, but not limited to, implied warranties of merchantability, fitness for a particular purpose, title, and non-infringement. In addition, while gosh attempts to provide a good user experience, we do not represent or warrant that:

the services will always be secure, error-free, or timely;
the services will always function without delays, disruptions, or imperfections;
that any gosh content, user content, or information you obtain on or through the services will be timely or accurate.
gosh takes no responsibility and assumes no liability for any content that you, another user, or a third party creates, uploads, posts, sends, receives, or stores on or through our services. you understand and agree that you may be exposed to content that might be offensive, illegal, misleading, or otherwise inappropriate, none of which gosh will be responsible for.

</br>
<h5>15. Limitation of Liability</h5>
To the maximum extent permitted by law, Gosh and our managing members, shareholders, employees, affiliates, licensors, and suppliers will not be liable for any indirect, incidental, special, consequential, punitive, or multiple damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from:

your access to or use of or inability to access or use the services;
the conduct or content of other users or third parties on or through the services;
unauthorized access, use, or alteration of your content, even if gosh has been advised of the possibility of such damages. In no event will Gosh's aggregate liability for all claims relating to the services exceed the greater of 100 usd or the amount you paid Gosh, if any, in the last 12 months.
Some jurisdictions do not allow the exclusion or limitation of certain damages, so some or all of the exclusions and limitations in this section may not apply to you.

</br>
<h5>16. Arbitration</h5>
This Gosh shall be construed and governed by the laws of Australia. Any and all disputes shall be first settled by the Parties’amicable negotiation. If the negotiation fails, the dispute shall be submitted to Australia International Arbitration Centre for arbitration in accordance with the arbitration rules in force when applied. The venue will be Australia. The arbitral award shall be final and binding upon the parties.

</br>
<h5>17. Choice of Law</h5>
Except to the extent they are preempted by the laws of Australia, other than its conflict-of-laws principles, govern these Terms and any disputes arising out of or relating to these Terms or their subject matter, including tort claims.

</br>
<h5>18. Severability</h5>
If any provision of these Terms is found unenforceable, then that provision will be severed from these Terms and not affect the validity and enforceability of any remaining provisions.

</br>
<h5>19. Additional Terms for Specific Services</h5>
Given the breadth of our Services, we sometimes need to craft additional terms and conditions for specific Services. Those additional terms and conditions, which will be available with the relevant Services, then become part of your agreement with us if you use those Services.

</br>
<h5>20. Final Terms</h5>
These Terms make up the entire agreement between you and Gosh, and supersede any prior agreements.
These Terms do no create or confer any third-party beneficiary rights.
If we do not enforce a provision in these Terms, it will not be considered a waiver.
We reserve all rights not expressly granted to you.
You may not transfer any of your rights or obligations under these Terms without our consent.
These Terms were written in English and to the extent the translated version of these Terms conflict with the English version, the English version will control.
<h5>Contact Us</h5>
Gosh welcomes comments, questions, concerns, or suggestions. Please send feedback to us by visiting https://gosh0.com<br>
Gosh is operated by Gosh Streaming PTY LTD. ''';

// Full Privacy Policy (optional: replace with your full version)
const String privacyContent = '''
                       <h1>Privacy Policy</h1>
<h5>1. INTRODUCTION</h5>
This is the Privacy Policy of Gosh Streaming PTY LTD and Gosh and its various & next versions including Gosh web version (hereinafter collectively referred to as "Gosh", "us", "we", or "our") and is incorporated into and is subject to our Terms of Use. In this Privacy Policy, we refer to our products and services as the "Service". Please read on to learn more about our data handling practices. Your use of the Service signifies that you agree with the terms of this Privacy Policy. If you do not agree with the terms of this Privacy Policy, please do not use the Service.
<h5>2. INFORMATION WE COLLECT</h5>
The personal data we collect depends on how you interact with us, the services you use, and the choices you make.
We collect information about you from different sources and in various ways when you use our services, including information you provide directly, information collected automatically, information from third-party data sources, and data we infer or generate from other data.

We collect the following categories of personal data that you provide directly to us: such as name and profile name, email address, address, and online identifiers, your sex or gender, gender identity that you provide in using Gosh, or other details that we do not ask for but that you choose to volunteer that may reveal characteristics of protected classifications under applicable law.
When users sign in with Google, Gosh will collect their nickname and avatar from Google, which will be used as default nickname and avatar for Gosh. Users can change or modify their nickname and avatar for Gosh later. Gosh ensures these collected data confidentially.
Face data, such as when you use some features provided by us to create special effects or emojis for your streaming section or pictures that you uploaded on Gosh Services, but such data will only be processed offline to fulfill the special effects or emojis and we will not use it for other purposes unless we have obtained your explicit consent or turn this into de-identified data; further, we will not use your face data for marketing or advertising, nor will we share such data with any third party. In addition, if you utilize Real-Person Profile Picture Authentication, we collect your profile picture and facial-recognition video for Real-Person Profile Picture Authentication on the premise of your approval by comparing your profile picture with face-recognition video. This authentication can protect you from impersonators and fake accounts, or develop the authenticity of Gosh Services. We do not retain your face recognition video in our servers, such video is merely for verifying.
User Content: In utilizing Gosh Services, you may contribute various forms of content, including but not limited to comments, texts, messages, pictures, videos, and audio recordings. All data uploaded, distributed, or streamed through the App is considered "User Content." Gosh retains and processes these communications and associated information to ensure that we comply with any applicable content regulations in any relevant jurisdiction.
Identifiers about you and your device(s). When you use our services we automatically log your Internet Protocol (IP) address and information about your device, including device identifiers (such as MAC address); device type; and your device operating system, browser, and other software including type, version, language, settings, and configuration. As further described in the Cookies, Web Beacons, and Other Technologies section below, our services automatically collect and store identifiers like the types described here using Technologies.
By choosing to share that information, you should understand that you may no longer be able to control how that information is used and that it may become publicly available (depending in part on your actions or the actions of others with whom you have shared the information). Gosh is not responsible for any use or misuse of information you share. In addition, in case your conversation partner reports your abusive behavior or language to us, then the conversation information such as voices, screenshots or contents of conversation which has been stored only in your partner's device may be transferred to our servers. Such transferred information will be processed by us to ascertain the genuineness of the report and determine your penalty levels, if needed.
When you are asked to provide personal data, you may decline. And you may use web browser or operating system controls to prevent certain types of automatic data collection. But if you choose not to provide or allow information that is necessary for certain services or features, those services or features may not be available or fully functional.
</br>
<h5>3. OUR USE OF PERSONAL DATA</h5>
We adopt the principle of data minimization when collecting and using your data, and ensure that your data is only used for the purposes described below. We will only process your data for other business purposes related to the service, such as: - Product improvement, development, and research. To develop new services or features, analyze use of the services, and to conduct research.

Product and service delivery. To provide and deliver our services, including maintaining accounts and services functionality, and troubleshooting, improving, and personalizing the services.
Business operations. To operate our business, such as by improving our internal operations, securing our systems, detecting and responding to fraudulent or illegal activity, monitoring for and responding to violations of our policies and guidelines, meeting our legal obligations, responding to legal and law enforcement claims and investigations, and facilitating our business transactions (such as mergers or acquisitions).
Personalization. To understand you and your preferences to enhance your experience and enjoyment using our services.
Customer support. To provide customer support, investigate and resolve disputes, and respond to your questions.
Communications. To send you information, including messages, confirmations, updates, and support and administrative messages.
Marketing. To communicate with you about new services, offers, promotions, rewards, contests, upcoming events, and other information about our services. - Advertising. To display advertising to you.
For internal operations, including troubleshooting problems, data analysis, testing, research, improvements to the Service, detecting and protecting against error, fraud or other illegal activity;
To protect against, identify, monitor and prevent fraud and other criminal activities, any other activities that may violate our Terms of Service or other applicable laws, or lead to claims or other liabilities.
To protect and defend our rights or property (including to enforce our Terms of Use and other agreements);
In connection with a corporate transaction involving Gosh, such as the purchase or sale of a business unit, an acquisition, merger, sale of assets, or other similar event.
Our processing activities include systematic scanning to detect and filter out malicious content, vigilant monitoring for abuse or prohibited imagery, and proactive utilization of user reports to address potential issues and ensure content security and user safety.
</br>
<h5>4. OUR DISCLOSURES OF PERSONAL DATA</h5>
We disclose personal data with your consent, or as we deem necessary for our business purposes including to provide the services to you. In addition, we disclose each of the categories of personal data described in the Personal Data We Collect section above, with the types of third parties described below, for the following business purposes:

We may share User Content and your information (including but not limited to, information from cookies, log files, device identifiers, location data, and usage data) with businesses that are legally part of the same group of companies that Gosh is part of, or that become part of that group ("Affiliates"). Affiliates may use this information to help provide, understand, and improve the Service (including by providing analytics) and Affiliates' own services (including by providing you with better and more relevant experiences). But these Affiliates will honor the choices you make about who can see your contents.
We also may share your information as well as information from tools like cookies, log files, and device identifiers and location data, with third-party organizations that help us provide the Service to you ("Service Providers"). Our Service Providers will be given access to your information as is reasonably necessary to provide the Service under reasonable confidentiality terms.
We may also share aggregate or anonymous information with third parties, including advertisers and investors. For example, we may tell our advertisers the number of users our app receives. This information does not contain any personal or personally identifiable information, and is used to develop content and services that we hope you will find of interest.
We may remove parts of data that can identify you and share anonymized data with other parties. We may also combine your information with other information in a way that it is no longe r associated with you and share that aggregated information.Parties with whom you may choose to share your User Content.
Any information or content that you voluntarily disclose for posting to the Service, such as User Content, becomes available to the public. With this feature, Gosh can be protected from exhibitionism. Once you have shared User Content or made it public, that User Content may be re-shared by others.
The information you enter into your user profile (your “Profile”) may be shared with your Gosh contacts. You control your Profile and you can access and modify your Profile from Gosh application at any time. Your Profile is available to other users of the Service who are connected to you on Gosh.
Outbound Links. If you accessed a website, product or service provided by a third party, including through the Service or Gosh website, such third party may also collect information about you. Please see the privacy policies of each such third party for more information about how they use the information they collect. This Privacy Policy does not apply to any exchange of information between you and any third party.
Third party service providers, such as analytics, personalization, fraud, security, and advertising companies also collect personal data through our website and apps using Technologies, as further described in the Cookies, Web Beacons, and Other Technologies section above.
</br>
<h5>5. YOUR PERSONAL DATA CHOICES AND OPTIONS</h5>
Depending on where you reside, you may have the right to: Access and To Know. If you wish to access personal data about you, you may access your account by logging into Gosh services you use and viewing some of the personal data associated with your account. You also have a right to request to know additional information about our collection, use, disclosure, or sale of personal data about you, including to request a copy of the personal data we have about you. Note that we have provided much of this information in this privacy statement. You may make such a "request to know" by contacting us at support@gosh.com

Choices for Technologies. See the Cookies, Web Beacons, and Other Technologies section above for details about choices and options for Technologies.
Correction. You may request correction of certain personal data about you. You can correct some personal data by logging into Gosh services you use and using options available to update personal data associated with your account. You can also contact us at support@gosh.com
Deletion. You can request that we delete personal data under certain circumstances, subject to a number of exceptions. To make a request to delete, you can contact us at support@gosh.com
Email preferences. You can choose whether to receive promotional emails from us. If you receive promotional emails from us and would like to stop, you can do so by following the directions in those emails. These choices do not apply to certain informational communications including surveys and mandatory service communications. You may also opt-out by contacting us at support@gosh.com
</br>
<h5>6. SECURITY OF PERSONAL DATA</h5>
Protecting user privacy and personal information is a top priority for Gosh Streaming PTY LTD and Gosh. We make substantial efforts to ensure the privacy of all personally identifiable information you provide to us. To help us protect personal data, we request that you use a strong password and never share your password with anyone or use the same password with other sites or accounts. When you delete your account, Gosh will stop providing services to you and delete or anonymize your personal information as required by applicable law.

</br>
<h5>7. PERSONAL INFORMATION OF CHILDREN</h5>
Our Service is designed for a general audience and is not directed towards children. In connection with our Service, we do not knowingly collect or maintain personal information from anyone under the age of eighteen (18) or knowingly allow such persons to use our Service. If you are under eighteen (18) please do not attempt to register for our Service or provide us with any personal information. If we learn that a person under the age of eighteen (18) has provided us with any personal information, we will promptly delete such personal information. If you believe that a child under age eighteen (18) may have provided us with personal information, please contact us using the information specified in the “Contact Us” section.

</br>
<h5>8. LOCATION OF PERSONAL DATA PROCESSING</h5>
The personal data we collect may be stored and processed in your country or region, or in any other country where we or our affiliates, subsidiaries, service providers, or thirdparty partners process data. For example, personal data will be processed in Singapore. We make commercially reasonable efforts with the intent of processing and protecting personal data according to the provisions of this statement and applicable law wherever the data is located.

</br>
<h5>9. NOTIFICATION OF CHANGES TO PRIVACY STATEMENT</h5>
We reserve the right at our discretion to make changes to this Privacy Policy. You may review updates to our Privacy Policy at any time via links on our website. You agree to accept electronic communications and/or postings of a revised Privacy Policy on Gosh Streaming PTY LTD. and Gosh website, and you agree that such electronic communications or postings constitute notice to you of the Privacy Policy. Please review it frequently.
When we post changes to the statement, we will revise the "Last Updated" date at the top of the statement. If we make material changes to this policy, we will notify you by publishing a revised Privacy Policy or by means of a notice on our website, or as required by law. You agree to review the Privacy Policy periodically so that you are aware of any modifications. You agree that your continued use of the Service after we publish a revised Privacy Policy or provide a notice on our website constitutes your acceptance of the revised Privacy Policy. If you do not agree with the terms of the Privacy Policy, you should not use the Service.
</br>

<h5>10. HOW TO CONTACT US</h5>
If you have any questions about this Privacy Policy or a question about Gosh, please contact us at support@gosh.com

</br>
<h5>11. DATE</h5>
This privacy policy was posted on 6/12/2024.
''';
