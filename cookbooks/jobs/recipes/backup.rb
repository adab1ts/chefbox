#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: jobs
# Recipe:: backup
#
# Copyright 2013, Carles Muiños
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
#


box  = node[:box]
jobs = node[:jobs]

backup_job_dir = "#{jobs[:path]}/backup"

directory backup_job_dir do
  owner box['default_user']
  group box['default_group']
  mode 0755
end


template "#{backup_job_dir}/backup.job" do
  source "/jobs/backup/backup.job.erb"
  owner box['default_user']
  group box['default_group']
  mode 0755
  backup false
  variables(
    :backup_job_path => backup_job_dir
  )
end


backup_script = "#{backup_job_dir}/backup-#{box['name']}"
backup_tasks  = jobs[:job_list][:backup][:tasks]

template backup_script do
  source "/jobs/backup/backup-box_name.erb"
  owner box['default_user']
  group box['default_group']
  mode 0755
  backup false
  variables(
    :backup_job_path => backup_job_dir,
    :box_name        => box['name'],
    :jobs_setup_file => "#{jobs[:path]}/setup",
    :backup_tasks    => backup_tasks
  )
end


backup_launcher = "#{backup_job_dir}/backup-mgr.desktop"

template backup_launcher do
  source "/jobs/backup/backup-mgr.desktop.erb"
  owner box['default_user']
  group box['default_group']
  mode 0644
  backup false
  variables(
    :backup_script => backup_script
  )
end


launchers_dir = "#{box['home']}/.local/share/applications"

directory launchers_dir do
  owner box['default_user']
  group box['default_group']
  mode 0755
end

link "#{launchers_dir}/backup-mgr.desktop" do
  to backup_launcher
  owner box['default_user']
  group box['default_group']
end


backup_tasks.each do |task|
  task_drive = task[:drive].split(' ').map(&:downcase).join('_')
  backup_task_dir = "#{backup_job_dir}/#{task_drive}"

  directory backup_task_dir do
    owner box['default_user']
    group box['default_group']
    mode 0755
  end

  template "#{backup_task_dir}/#{task[:name]}" do
    source "/jobs/backup/drive/backup-drive.erb"
    owner box['default_user']
    group box['default_group']
    mode 0755
    backup false
    variables(
      :backup_task_dir     => backup_task_dir,
      :backup_task_name    => task[:name],
      :backup_drive        => task[:drive],
      :backup_task_folder  => task[:folder],
      :backup_task_drive   => task_drive,
      :backup_task_targets => task[:targets]
    )
  end

  task[:targets].each do |target|
    template "#{backup_task_dir}/#{task[:name]}-#{target}" do
      source "/jobs/backup/drive/backup-drive-target.erb"
      owner box['default_user']
      group box['default_group']
      mode 0755
      backup false
      variables(
        :backup_task_dir    => backup_task_dir,
        :backup_task_name   => task[:name],
        :backup_task_drive  => task_drive,
        :backup_task_target => target
      )
    end

    template "#{backup_task_dir}/#{task[:name]}-#{target}-excl_patterns.lst" do
      source "/jobs/backup/drive/backup-drive-target-excl_patterns.lst.erb"
      owner box['default_user']
      group box['default_group']
      mode 0644
      backup false
    end

    home_folders = data_bag_item('global', 'home_folders')
    incl_patterns_list = home_folders[box['lang']].map { |folder| "#{folder}/***\n" }.join
    incl_patterns_file = "#{backup_task_dir}/#{task[:name]}-#{target}-incl_patterns.lst"

    file incl_patterns_file do
      content incl_patterns_list
      owner box['default_user']
      group box['default_group']
      mode 0644
      backup false
    end
  end
end

