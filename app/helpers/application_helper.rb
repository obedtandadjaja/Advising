#
#   Copyright 2015 Amy Dewaal and Obed Tandadjaja
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

module ApplicationHelper

  # merge the devise messages with the normal flash messages
  def devise_flash
    if controller.devise_controller? && resource.errors.any?
      flash.now[:danger] = flash[:danger].to_a.concat resource.errors.full_messages
      flash.now[:danger].uniq!
    end
  end

end
