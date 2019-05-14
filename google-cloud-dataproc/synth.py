# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""This script is used to synthesize generated parts of this library."""

import synthtool as s
import synthtool.gcp as gcp
import synthtool.languages.ruby as ruby
import logging
import re

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v1_library = gapic.ruby_library(
    'dataproc', 'v1', config_path='/google/cloud/dataproc/artman_dataproc_v1.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-dataproc'
)
s.copy(v1_library / 'acceptance')
s.copy(v1_library / 'lib')
s.copy(v1_library / 'test')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-dataproc.gemspec', merge=ruby.merge_gemspec)

v1beta2 = gapic.ruby_library(
    'dataproc', 'v1beta2', config_path='/google/cloud/dataproc/artman_dataproc_v1beta2.yaml',
    artman_output_name='google-cloud-ruby/google-cloud-dataproc'
)
s.copy(v1beta2 / 'lib/google/cloud/dataproc/v1beta2')
s.copy(v1beta2 / 'lib/google/cloud/dataproc/v1beta2.rb')
s.copy(v1beta2 / 'acceptance/google/cloud/dataproc/v1beta2')
s.copy(v1beta2 / 'test/google/cloud/dataproc/v1beta2')

# Copy common templates
templates = gcp.CommonTemplates().ruby_library()
s.copy(templates)

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('^([^`]*(`[^`]*`[^`]*)*)([^`#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\3\\\\\\\\{\\4}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/dataproc/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)

# https://github.com/googleapis/gapic-generator/issues/2393
s.replace(
    'google-cloud-dataproc.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.64.0"'
)

s.replace(
    'lib/google/cloud/dataproc.rb',
    'WorkflowTemplate\\.new',
    'WorkflowTemplateService.new'
)

s.replace(
    [
        'lib/google/cloud/dataproc/v*/workflow_template_service_client.rb',
        'test/google/cloud/dataproc/v*/workflow_template_service_client_test.rb'
    ],
    'WorkflowTemplate\\.new\\(version:',
    'WorkflowTemplateService.new(version:'
)

# https://github.com/googleapis/gapic-generator/issues/2492
s.replace(
    [
        'lib/google/cloud/dataproc.rb',
        'lib/google/cloud/dataproc/v*.rb'
    ],
    'module WorkflowTemplate\n',
    'module WorkflowTemplateService\n'
)

# https://github.com/googleapis/gapic-generator/issues/2232
s.replace(
    'lib/google/cloud/dataproc/v*/cluster_controller_client.rb',
    '\n\n(\\s+)class OperationsClient < Google::Longrunning::OperationsClient',
    '\n\n\\1# @private\n\\1class OperationsClient < Google::Longrunning::OperationsClient'
)

s.replace(
    'google-cloud-dataproc.gemspec',
    '"README.md", "LICENSE"',
    '"README.md", "AUTHENTICATION.md", "LICENSE"'
)
s.replace(
    '.yardopts',
    'README.md\n',
    'README.md\nAUTHENTICATION.md\nLICENSE\n'
)

# https://github.com/googleapis/google-cloud-ruby/issues/3058
s.replace(
    'google-cloud-dataproc.gemspec',
    '\nGem::Specification.new do',
    'require File.expand_path("../lib/google/cloud/dataproc/version", __FILE__)\n\nGem::Specification.new do'
)
s.replace(
    'google-cloud-dataproc.gemspec',
    '(gem.version\s+=\s+).\d+.\d+.\d.*$',
    '\\1Google::Cloud::Dataproc::VERSION'
)
for version in ['v1', 'v1beta2']:
    s.replace(
        f'lib/google/cloud/dataproc/{version}/*_client.rb',
        f'(require \".*credentials\"\n)\n',
        f'\\1require "google/cloud/dataproc/version"\n\n'
    )
    s.replace(
        f'lib/google/cloud/dataproc/{version}/*_client.rb',
        'Gem.loaded_specs\[.*\]\.version\.version',
        'Google::Cloud::Dataproc::VERSION'
    )
