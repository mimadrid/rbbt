# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rbbt}
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Miguel Vazquez"]
  s.date = %q{2010-05-27}
  s.default_executable = %q{rbbt_config}
  s.description = %q{This toolbox includes modules for text-mining, like Named Entity Recognition and Normalization and document
    classification, as well as data integration modules that interface with PubMed, Entrez Gene, BioMart.}
  s.email = %q{miguel.vazquez@fdi.ucm.es}
  s.executables = ["rbbt_config"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "bin/rbbt_config",
     "install_scripts/classifier/R/classify.R",
     "install_scripts/classifier/Rakefile",
     "install_scripts/get_abner.sh",
     "install_scripts/get_banner.sh",
     "install_scripts/get_biocreative.sh",
     "install_scripts/get_crf++.sh",
     "install_scripts/get_entrez.sh",
     "install_scripts/get_go.sh",
     "install_scripts/get_polysearch.sh",
     "install_scripts/ner/Rakefile",
     "install_scripts/ner/config/default.rb",
     "install_scripts/norm/Rakefile",
     "install_scripts/norm/config/cue_default.rb",
     "install_scripts/norm/config/tokens_default.rb",
     "install_scripts/norm/functions.sh",
     "install_scripts/organisms/Ath.Rakefile",
     "install_scripts/organisms/Cal.Rakefile",
     "install_scripts/organisms/Cel.Rakefile",
     "install_scripts/organisms/Hsa.Rakefile",
     "install_scripts/organisms/Mmu.Rakefile",
     "install_scripts/organisms/Rakefile",
     "install_scripts/organisms/Rno.Rakefile",
     "install_scripts/organisms/Sce.Rakefile",
     "install_scripts/organisms/Spo.Rakefile",
     "install_scripts/organisms/rake-include.rb",
     "install_scripts/wordlists/consonants",
     "install_scripts/wordlists/stopwords",
     "lib/rbbt.rb",
     "lib/rbbt/bow/bow.rb",
     "lib/rbbt/bow/classifier.rb",
     "lib/rbbt/bow/dictionary.rb",
     "lib/rbbt/ner/abner.rb",
     "lib/rbbt/ner/banner.rb",
     "lib/rbbt/ner/dictionaryNER.rb",
     "lib/rbbt/ner/regexpNER.rb",
     "lib/rbbt/ner/rner.rb",
     "lib/rbbt/ner/rnorm.rb",
     "lib/rbbt/ner/rnorm/cue_index.rb",
     "lib/rbbt/ner/rnorm/tokens.rb",
     "lib/rbbt/sources/biocreative.rb",
     "lib/rbbt/sources/biomart.rb",
     "lib/rbbt/sources/entrez.rb",
     "lib/rbbt/sources/go.rb",
     "lib/rbbt/sources/gscholar.rb",
     "lib/rbbt/sources/organism.rb",
     "lib/rbbt/sources/polysearch.rb",
     "lib/rbbt/sources/pubmed.rb",
     "lib/rbbt/util/arrayHash.rb",
     "lib/rbbt/util/filecache.rb",
     "lib/rbbt/util/index.rb",
     "lib/rbbt/util/misc.rb",
     "lib/rbbt/util/open.rb",
     "lib/rbbt/util/rake.rb",
     "lib/rbbt/util/simpleDSL.rb",
     "lib/rbbt/util/tmpfile.rb",
     "tasks/install.rake"
  ]
  s.homepage = %q{http://github.com/mikisvaz/rbbt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Bioinformatics and text mining toolbox}
  s.test_files = [
    "test/test_rbbt.rb",
     "test/rbbt/bow/test_bow.rb",
     "test/rbbt/bow/test_classifier.rb",
     "test/rbbt/bow/test_dictionary.rb",
     "test/rbbt/sources/test_organism.rb",
     "test/rbbt/sources/test_biomart.rb",
     "test/rbbt/sources/test_pubmed.rb",
     "test/rbbt/sources/test_polysearch.rb",
     "test/rbbt/sources/test_biocreative.rb",
     "test/rbbt/sources/test_entrez.rb",
     "test/rbbt/sources/test_go.rb",
     "test/rbbt/ner/test_rner.rb",
     "test/rbbt/ner/test_dictionaryNER.rb",
     "test/rbbt/ner/test_banner.rb",
     "test/rbbt/ner/test_rnorm.rb",
     "test/rbbt/ner/test_regexpNER.rb",
     "test/rbbt/ner/test_abner.rb",
     "test/rbbt/ner/rnorm/test_cue_index.rb",
     "test/rbbt/ner/rnorm/test_tokens.rb",
     "test/rbbt/util/test_misc.rb",
     "test/rbbt/util/test_tmpfile.rb",
     "test/rbbt/util/test_arrayHash.rb",
     "test/rbbt/util/test_filecache.rb",
     "test/rbbt/util/test_simpleDSL.rb",
     "test/rbbt/util/test_open.rb",
     "test/rbbt/util/test_index.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.8.4"])
      s.add_runtime_dependency(%q<simpleconsole>, [">= 0"])
      s.add_runtime_dependency(%q<stemmer>, [">= 0"])
      s.add_runtime_dependency(%q<progress-monitor>, [">= 0"])
      s.add_runtime_dependency(%q<simpleconsole>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.4"])
      s.add_dependency(%q<simpleconsole>, [">= 0"])
      s.add_dependency(%q<stemmer>, [">= 0"])
      s.add_dependency(%q<progress-monitor>, [">= 0"])
      s.add_dependency(%q<simpleconsole>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.4"])
    s.add_dependency(%q<simpleconsole>, [">= 0"])
    s.add_dependency(%q<stemmer>, [">= 0"])
    s.add_dependency(%q<progress-monitor>, [">= 0"])
    s.add_dependency(%q<simpleconsole>, [">= 0"])
  end
end

