# @default_files = ('main.tex');
#
# add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
# add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
#
# sub run_makeglossaries {
#   if ( $silent ) {
#     system "makeglossaries -q -s '$_[0].ist' '$_[0]'";
#   }
#   else {
#     system "makeglossaries -s '$_[0].ist' '$_[0]'";
#   };
# }
#
# push @generated_exts, 'glo', 'gls', 'glg';
# push @generated_exts, 'acn', 'acr', 'alg';
# $clean_ext .= ' %R.ist %R.xdy';
#
