import time
import json
import configparser
from csv import reader
from azure.eventhub import EventHubProducerClient, EventData

# TO-DO adding data ouput a
config = configparser.ConfigParser()
config.read('config.ini')
connection_str = config['EVENTHUB']['EVENTHUB_CONNCECTION_STRING']
eventhub_name = config['EVENTHUB']['EVENTHUB_NAME']


class SampleData:
    def __init__(self, attr1, attr2, attr3):
        self.attr1 = attr1
        self.attr2 = attr2
        self.attr3 = attr3

    def __str__(self):
        return f"{self.attr1}, {self.attr2}, {self.attr3}"


def send_to_eventhub(client, data):
    event_data_batch = client.create_batch()
    event_data_batch.add(EventData(data))
    client.send_batch(event_data_batch)


def main():
    with open('<DATA>', 'r') as _data:
        csv_reader = reader(_data)
        header = next(_data)

        attr2s = header[:-1].split(',')[1:]
        client = EventHubProducerClient.from_connection_string(conn_str=connection_str, eventhub_name=eventhub_name)
        for row in csv_reader:
            date = row[0]
            i = 1
            for attr2 in attr2s:
                sampleBatch = SampleData(date, attr2, row[i])
                send_to_eventhub(client, json.dumps(sampleBatch.__dict__))
                print(json.dumps(sampleBatch.__dict__))
                i += 1
            time.sleep(3)


main()