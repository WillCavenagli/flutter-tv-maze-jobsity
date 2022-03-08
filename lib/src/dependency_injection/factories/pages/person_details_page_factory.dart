import 'package:flutter/material.dart';

import '../../../presentation/presenters/person_details_presenter/person_details_presenter.dart';
import '../../injection_container.dart';
import '../../../ui/pages/person_details/person_details_page.dart';

Widget makePersonDetailsPage() => PersonDetailsPage(
      presenter: serviceLocator<PersonDetailsPresenter>(),
    );
