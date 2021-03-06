# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Shell
  module Commands
    class CreateCrosssitetable < Command
      def help
        return <<-EOF
Creates a cross-site table

  hbase> create_crosssitetable 't1', {NAME => 'f1', VERSIONS => 5}
  hbase> create_crosssitetable 't1', {NAME => 'f1'}, {NAME => 'f2'}, {NAME => 'f3'}
  hbase> # The above in shorthand would be the following:
  hbase> create_crosssitetable 't1', 'f1', 'f2', 'f3'
  hbase> create_crosssitetable 't1', {NAME => 'f1', VERSIONS => 1, TTL => 2592000, BLOCKCACHE => true}
  hbase> create_crosssitetable 't1', 'f1', {SPLITS => ['10', '20', '30', '40']}
  hbase> create_crosssitetable 't1', 'f1', {SPLITS_FILE => 'splits.txt'}
  hbase> # Optionally pre-split the table into NUMREGIONS, using
  hbase> # SPLITALGO ("HexStringSplit", "UniformSplit" or classname)
  hbase> create_crosssitetable 't1', 'f1', {NUMREGIONS => 15, SPLITALGO => 'HexStringSplit'}
  hbase> create_crosssitetable 't1', 'f1', {SPLITS => ['10', '20']}, {LOCATOR => 'org.apache.hadoop.hbase.crosssite.locator.SubstringClusterLocator', LOCATOR_ARGS=>['5','7']}

EOF
      end
      def command(table, *args)
        format_simple_command do
          crosssite_admin.create(table, *args)
        end
      end
    end
  end
end