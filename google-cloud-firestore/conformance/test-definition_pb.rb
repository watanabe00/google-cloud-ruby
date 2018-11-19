# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: test-definition.proto

require 'google/protobuf'

require 'google/firestore/v1beta1/common_pb'
require 'google/firestore/v1beta1/document_pb'
require 'google/firestore/v1beta1/firestore_pb'
require 'google/firestore/v1beta1/query_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "tests.TestSuite" do
    repeated :tests, :message, 1, "tests.Test"
  end
  add_message "tests.Test" do
    optional :description, :string, 1
    oneof :test do
      optional :get, :message, 2, "tests.GetTest"
      optional :create, :message, 3, "tests.CreateTest"
      optional :set, :message, 4, "tests.SetTest"
      optional :update, :message, 5, "tests.UpdateTest"
      optional :update_paths, :message, 6, "tests.UpdatePathsTest"
      optional :delete, :message, 7, "tests.DeleteTest"
      optional :query, :message, 8, "tests.QueryTest"
      optional :listen, :message, 9, "tests.ListenTest"
    end
  end
  add_message "tests.GetTest" do
    optional :doc_ref_path, :string, 1
    optional :request, :message, 2, "google.firestore.v1beta1.GetDocumentRequest"
  end
  add_message "tests.CreateTest" do
    optional :doc_ref_path, :string, 1
    optional :json_data, :string, 2
    optional :request, :message, 3, "google.firestore.v1beta1.CommitRequest"
    optional :is_error, :bool, 4
  end
  add_message "tests.SetTest" do
    optional :doc_ref_path, :string, 1
    optional :option, :message, 2, "tests.SetOption"
    optional :json_data, :string, 3
    optional :request, :message, 4, "google.firestore.v1beta1.CommitRequest"
    optional :is_error, :bool, 5
  end
  add_message "tests.UpdateTest" do
    optional :doc_ref_path, :string, 1
    optional :precondition, :message, 2, "google.firestore.v1beta1.Precondition"
    optional :json_data, :string, 3
    optional :request, :message, 4, "google.firestore.v1beta1.CommitRequest"
    optional :is_error, :bool, 5
  end
  add_message "tests.UpdatePathsTest" do
    optional :doc_ref_path, :string, 1
    optional :precondition, :message, 2, "google.firestore.v1beta1.Precondition"
    repeated :field_paths, :message, 3, "tests.FieldPath"
    repeated :json_values, :string, 4
    optional :request, :message, 5, "google.firestore.v1beta1.CommitRequest"
    optional :is_error, :bool, 6
  end
  add_message "tests.DeleteTest" do
    optional :doc_ref_path, :string, 1
    optional :precondition, :message, 2, "google.firestore.v1beta1.Precondition"
    optional :request, :message, 3, "google.firestore.v1beta1.CommitRequest"
    optional :is_error, :bool, 4
  end
  add_message "tests.SetOption" do
    optional :all, :bool, 1
    repeated :fields, :message, 2, "tests.FieldPath"
  end
  add_message "tests.QueryTest" do
    optional :coll_path, :string, 1
    repeated :clauses, :message, 2, "tests.Clause"
    optional :query, :message, 3, "google.firestore.v1beta1.StructuredQuery"
    optional :is_error, :bool, 4
  end
  add_message "tests.Clause" do
    oneof :clause do
      optional :select, :message, 1, "tests.Select"
      optional :where, :message, 2, "tests.Where"
      optional :order_by, :message, 3, "tests.OrderBy"
      optional :offset, :int32, 4
      optional :limit, :int32, 5
      optional :start_at, :message, 6, "tests.Cursor"
      optional :start_after, :message, 7, "tests.Cursor"
      optional :end_at, :message, 8, "tests.Cursor"
      optional :end_before, :message, 9, "tests.Cursor"
    end
  end
  add_message "tests.Select" do
    repeated :fields, :message, 1, "tests.FieldPath"
  end
  add_message "tests.Where" do
    optional :path, :message, 1, "tests.FieldPath"
    optional :op, :string, 2
    optional :json_value, :string, 3
  end
  add_message "tests.OrderBy" do
    optional :path, :message, 1, "tests.FieldPath"
    optional :direction, :string, 2
  end
  add_message "tests.Cursor" do
    optional :doc_snapshot, :message, 1, "tests.DocSnapshot"
    repeated :json_values, :string, 2
  end
  add_message "tests.DocSnapshot" do
    optional :path, :string, 1
    optional :json_data, :string, 2
  end
  add_message "tests.FieldPath" do
    repeated :field, :string, 1
  end
  add_message "tests.ListenTest" do
    repeated :responses, :message, 1, "google.firestore.v1beta1.ListenResponse"
    repeated :snapshots, :message, 2, "tests.Snapshot"
    optional :is_error, :bool, 3
  end
  add_message "tests.Snapshot" do
    repeated :docs, :message, 1, "google.firestore.v1beta1.Document"
    repeated :changes, :message, 2, "tests.DocChange"
    optional :read_time, :message, 3, "google.protobuf.Timestamp"
  end
  add_message "tests.DocChange" do
    optional :kind, :enum, 1, "tests.DocChange.Kind"
    optional :doc, :message, 2, "google.firestore.v1beta1.Document"
    optional :old_index, :int32, 3
    optional :new_index, :int32, 4
  end
  add_enum "tests.DocChange.Kind" do
    value :KIND_UNSPECIFIED, 0
    value :ADDED, 1
    value :REMOVED, 2
    value :MODIFIED, 3
  end
end

module Tests
  TestSuite = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.TestSuite").msgclass
  Test = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Test").msgclass
  GetTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.GetTest").msgclass
  CreateTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.CreateTest").msgclass
  SetTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.SetTest").msgclass
  UpdateTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.UpdateTest").msgclass
  UpdatePathsTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.UpdatePathsTest").msgclass
  DeleteTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.DeleteTest").msgclass
  SetOption = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.SetOption").msgclass
  QueryTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.QueryTest").msgclass
  Clause = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Clause").msgclass
  Select = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Select").msgclass
  Where = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Where").msgclass
  OrderBy = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.OrderBy").msgclass
  Cursor = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Cursor").msgclass
  DocSnapshot = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.DocSnapshot").msgclass
  FieldPath = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.FieldPath").msgclass
  ListenTest = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.ListenTest").msgclass
  Snapshot = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.Snapshot").msgclass
  DocChange = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.DocChange").msgclass
  DocChange::Kind = Google::Protobuf::DescriptorPool.generated_pool.lookup("tests.DocChange.Kind").enummodule
end