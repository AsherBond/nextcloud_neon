part of '../../neon.dart';

class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({
    required this.bloc,
    required this.account,
    super.key,
  });

  final AccountsBloc bloc;
  final Account account;

  late final _options = bloc.getOptionsFor(account);
  late final _userDetailsBloc = bloc.getUserDetailsBlocFor(account);
  late final _name = account.client.humanReadableID;

  @override
  Widget build(final BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(_name),
          actions: [
            IconButton(
              onPressed: () async {
                // ignore: use_build_context_synchronously
                if (await showConfirmationDialog(
                  context,
                  // ignore: use_build_context_synchronously
                  AppLocalizations.of(context).accountOptionsRemoveConfirm(account.client.humanReadableID),
                )) {
                  final isActive = bloc.activeAccount.value == account;

                  bloc.removeAccount(account);

                  if (isActive) {
                    // ignore: use_build_context_synchronously
                    const HomeRoute().go(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                }
              },
              tooltip: AppLocalizations.of(context).accountOptionsRemove,
              icon: Icon(MdiIcons.delete),
            ),
            IconButton(
              onPressed: () async {
                // ignore: use_build_context_synchronously
                if (await showConfirmationDialog(
                  context,
                  // ignore: use_build_context_synchronously
                  AppLocalizations.of(context).settingsResetForConfirmation(_name),
                )) {
                  await _options.reset();
                }
              },
              tooltip: AppLocalizations.of(context).settingsResetFor(_name),
              icon: Icon(MdiIcons.cogRefresh),
            ),
          ],
        ),
        body: ResultBuilder<NextcloudProvisioningApiUserDetails>.behaviorSubject(
          stream: _userDetailsBloc.userDetails,
          builder: (final context, final userDetails) => SettingsList(
            categories: [
              SettingsCategory(
                title: Text(AppLocalizations.of(context).accountOptionsCategoryStorageInfo),
                tiles: [
                  CustomSettingsTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userDetails.data != null) ...[
                          LinearProgressIndicator(
                            value: userDetails.data!.quota.relative / 100,
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppLocalizations.of(context).accountOptionsQuotaUsedOf(
                              filesize(userDetails.data!.quota.used, 1),
                              filesize(userDetails.data!.quota.total, 1),
                              userDetails.data!.quota.relative.toString(),
                            ),
                          ),
                        ],
                        NeonException(
                          userDetails.error,
                          onRetry: _userDetailsBloc.refresh,
                        ),
                        NeonLinearProgressIndicator(
                          visible: userDetails.isLoading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SettingsCategory(
                title: Text(AppLocalizations.of(context).optionsCategoryGeneral),
                tiles: [
                  DropdownButtonSettingsTile(
                    option: _options.initialApp,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
