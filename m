Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D83624DB
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296115; cv=fail; b=oRWvr+N6wA5rQj7KrptUCBVpyIcf7Kgjgn3rE0x6JQTPjQKynrXftv2nKoIF8IcE3yphYRmuJ/ajwNv4rwQP6QpwNp6EwzeqbIHM8E0va9tASJARza4TZW2bKkOdxYkMYB80KF9Hofqr5EPL+QQRbemac5QnAa1DvbGX+TBPmHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296115; c=relaxed/simple;
	bh=osSNkF6XqUv/eBM/wbyHLH+H5PefJ1oywgLLkoHvj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ePA612rI4miHMPPU3ZBIXc4WcgZAcuILQtB7RTB8Pstc8fmGEQRYjvbq6nhpt7LwSlOdsfQpI/aGrCVgcfWS3Cfp41cUoQzizAzyoQ5nSjcy8CQ5HOahJl6kn7mCaK/aTbgudish6MHu/NPol4wMyhKC1YUL0VuV0Ek2fibsplc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWuJhVai; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWuJhVai"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDbuf3Z+pWvPmvnOrPWeb+YpCN9fKYZYGump3HstdHi7kMvW1RPrZc6mZNDOjoRfObC96VbU7Z62rDC4jQxQPMVylTCebhZVyJxnfMYbRewlDys52VnIJ3uhBviGqPzHT4kQXELnFdgtj2cjgB8kSWhKrQbQBCSFtXv0RhqwBwzqzwi1TsIMABcgAKSsNCCgkp2RVP9urwmAIrQ+6V60/hKj/qHWCiK8ylIsmsLcgJ6KhmOO6/s2lWLchzILW6hW2EtatubOre2UVpKvMLWuBB8KAfGbjOCDuyUclt0pJSeRzOZwuiAWq+OhvpNJXeC0Opnzs9+LD+XHVsFSfclQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osSNkF6XqUv/eBM/wbyHLH+H5PefJ1oywgLLkoHvj3A=;
 b=qYTInh/b5UwYZP850CWwhHmz4yxFAUZ8l9ZsmfEJWmFqJkYJ+SieGZdXpD6DituyP4hYQ3o119brzYXj+khfIcA5/FpDXxWdmtXPSY5ilAP+3NyhOJYkb/UzXPsRSkNMNv7Xe5PLivfDQbYCJ4O73n1fXqhlhoD6TZHIdZLWN+NsfbUtyJMqwJutJiDO9zBgEuf/29fZjj9G2S7uQ8bxjbsVaI25yIeLs+9Tsj5pSoVy5p6FB69QPU6Gqi/0u2z7jRMBFiwPM7q20NJd9NglYZAQJcGcbz3Km82tONvi47hzD8sh6+g+sjS/GznlFjaFtNZRdRiqLPsYYtEeeNSekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osSNkF6XqUv/eBM/wbyHLH+H5PefJ1oywgLLkoHvj3A=;
 b=bWuJhVaioFllmdZPYqtLt/jYM8WVZQl2ImZh6/2zWSxZb3ruSXSXquSlpglVp2iVz1J/k0F3oiAc0uXgvhvb8KeDDCkvIbCT10gAi4ZKxCNerWsER1MKaxnILKAL2KoUIvTR35mbjA0Wc40mxx/RY47XV521yP47fTJKhZ3XvM9cKiP+Vka4LF8xokk8Mr6ybrKnrKFxOazaKJpJolrdqrqD9EObczesx8VQZS6BV2xkcRakjjzTYfI+c3J9Ia7L+B71Vj3fZ19SA3AWJwOaFGnxRxGj9NbuLc/ZbY5YVP6QkblIiOKRsskEjUpvcFtAHrMhRmAPbAENiEwY+3z/wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 06:41:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 06:41:49 +0000
Date: Mon, 1 Jun 2026 08:41:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [ANNOUNCEMENT/CFP] LPC 2026 sched_ext Microconference
Message-ID: <ah0poFjR91-HFbDI@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: affe7457-8734-468c-9c1e-08debfa8db71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2xCHci21SMK1oovXxXJxPZznZTXC8RoKVmbe4RqL5qi8q+o3WK+K4rW7JusRlnjoYE/k0y4ZkyrFz7Htkn8QUbY4eYIGHs4BHAWUY4Eu5/A/YQ0elAAL7diiAggdz1IHdR0TDKmCl49NDgbFWuPmAbcdqbi+gU7ew10ywWJRjoWa3TBlIzGTJU5N/wHasMDE2eo7ohfnA9VrSiGNfRIA83uT5FrY29GqiM4NfjQCABlg3+fvW1YA1QlyKa9fZTGy5uIYHc9M769ms6GVnfzvBwCLYM2fe+AsMfrO/PYlPlY0KFKhooNMw6pgBKaMmMMdC+NFpJbiqVN+eUImz9rhbP4ZfVcFpP76S7/c5qQdqEGN+VgkqZPMTryBiH4NlelepBL7E8Ip7RayMXqOvdh/ve2mOqBgBmyOAO/eiGfa+Ned+dcqAUAvozm2BYmkRKR9hBCW7ioGbRLDgcLaa4fNehESva8lCi+H9oqcJr8aJO027cNJiBr7+LLZJJHu/0G8QWdlg5bxOZJFE7EgY+jCWHC7S/TYBkX2VIluiPWCpTD/tV1h8ZAjtAIdYwyVvp1d32lB23jqw0Mh/6qxP3vEDriVunwjRxdvQWJCcDAnRmtf4pPqyA6ghbPmIFTEAJxPCtXjRKYHf0rzdy/5Ug6KQWslrURK5I2ZYZWEv98QK2nqDgUROpFVBNl7fpDkjBuiHpOEaaxu1Yl1zpWMwNnL4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anpQNEpUcUhWbkxvVU1QU1RuQm14WWpOSldDUkFxWFpZQnI0cjJCejVJM2VY?=
 =?utf-8?B?WWFRc1Y4K0dtMTlqajhOSjNoUUVpeWJsV2c1QXNCeU9EcUhvWTNVeFFxTFRQ?=
 =?utf-8?B?WjRYZFhyc2JXNzVIZFNGQjh4Z2tjcXBIcUw0Yi8xVzZhSEV5T3VKZnlaaUh5?=
 =?utf-8?B?ZmhVcFU5UXRCSUV1MVBzaDBFdFpNMGZ4TjhRaEE2NWJQMTBZTWZoL0Y4Y3gx?=
 =?utf-8?B?QncwUWNYWVFDUWFycWNYOWd1cWJ6YXlxRjZZelh3clNxcjBXa0E1c3p4RWNE?=
 =?utf-8?B?UjNQUURZRFZHbk1sTDh2amdvK3EzS3ZWM1RuNXJFZE1uaXhlaEZqT1JTSWd4?=
 =?utf-8?B?OHQvR3R3K0srQ2xoVW0zcUYvYXhydjR1MU1MNHRvVit5ZHIvYlRYamgrUkV3?=
 =?utf-8?B?RHF6ZCtvVDYxaEZlVGZxZ1A3VG9HdmJGVXhCK2NxUEFKb25OMVU5Z0RVSGw0?=
 =?utf-8?B?WmdVeTJBa3NrcENPWEQ5ZENiRWUrbUUydDE0c2s5bGVhTXZUblJtT0Z4Ly9s?=
 =?utf-8?B?VlIzcFJoK2hPWnhtQkNxR2RLSG45ZHhGc3NYUjNacm9ZRmZTRTVFYlgzNTkw?=
 =?utf-8?B?OGxvSGswODUrVGhHc1EyVERVL1VRM0VqdlAyaDltSGdTY28rem1xOXdBN0Qv?=
 =?utf-8?B?RWJ1cit3bVpORm1zdWFqWkNBWmVlSnhRZmU3bSt3RS9lTmtlelBHRDFGNk01?=
 =?utf-8?B?TExPekI4MC9ZSHNsOUF3ZXBWS2NNSXd1NHZkUWdheU1xSmwwN1VOZlZZZnJn?=
 =?utf-8?B?aU1nbE05SUhKNDVibWtOY08rSjFMSTVEWDNBdzQ1QWlXUzBWcHpHdWNyTTFl?=
 =?utf-8?B?S2JXb0lxR0Zqc1ZrdjgwYzBZYTFLOUlDVGZCd1loNEx1Q0tlSXU1R2lZSVlr?=
 =?utf-8?B?RDFPeXJ3WWJHTS83Z0Y5QWxxeGRjYUluRHlvZ3JEM2htSFNiZXFTd3BUNzFw?=
 =?utf-8?B?a3NMSVYxbXV5MkZRZlhlQjU1OFR2dVZpN1dITUxtWTF6VklYTUlibHlET2ds?=
 =?utf-8?B?YU5TKzZVTkJjd1V6S1JUYnlaOGgzWWthaVlKdVpzYms4YW0vd2prMnVkU09w?=
 =?utf-8?B?a0IzK1FKVWlhL2Jrb3BFcGRDQW1scVQ2ZklLWGN2Um1lb0c2b2ZRYmdQdlZG?=
 =?utf-8?B?MkJSakpoY1RYbWEvbDVCZU9weUV4T3N5c1ZOL0dGbUlmdkRZVjIyS0FBazIw?=
 =?utf-8?B?a3hFSUliZ0hyT3BsenZKRit4NlVEZzArZXptUnNkOWU2ajYveFFvN3VFQk82?=
 =?utf-8?B?WHVnWWVLSUs3T1RhMEdmUjIxTWVCcVVhcDlNSno1SkU2Uk5nVWpZMjczTmhF?=
 =?utf-8?B?Sm11ZXl4akxqL3dvZGZRV2pBQXB6MzdRTnFpNEdtY1pPT1pubGpTLzl0Sm1J?=
 =?utf-8?B?ZXprTXBnM1QwVlhOQ2JOLzJZaWQ0aFNpcTVzZ0E4c1ppRnlwOTVKaElmT1RJ?=
 =?utf-8?B?N1pSemlOQU1sdlZlNnRlRHB6a0FpYm55THRWSXRUbzdXWkxabk9uRkpJcko1?=
 =?utf-8?B?dUorUjJCTWlqR0k0clRpMjFiN25VTEoxUXJVeHZGVFloZ0dvODFmU3U2Nmpp?=
 =?utf-8?B?UmhNZEREWmp2WmRQU2ZhTnN1clcySm1BL0tZbEQ5QXpRYkFWZkMrTFFrVzgr?=
 =?utf-8?B?ZWlXZ3YyTFZCbHRqU2xvTFcwR1FWenZIa1JQNGU2TVpSL3JxUWZVK3FxZ2hw?=
 =?utf-8?B?T1Awelhwa21GaGY3bDdvVUc3TlBZZCtva2tzSmY3UzZtRCsxR2Z0aVYrb2t1?=
 =?utf-8?B?eXdaSjJydktVUlhUUzludk5IV0RiSFJ3dDJyUFdKeGN4MnovODFrTkFGYzZT?=
 =?utf-8?B?M0J1enRJT2JHdGZjQ0JMSk92eGdwUVhGRFU4UzRFNmZuUENrOEdLWUFxOGlD?=
 =?utf-8?B?bm94SE5vRHQ4WitXa0JFTmc1aStDSFpZbDZXY3RxcmhZUFI2eitvN2hwUjA4?=
 =?utf-8?B?OUNUeVdqTTg0d3lJdUZTZ0FxY0s1NVlsZ0ZlWXFWbk9YbWtZZDRJcURGZTlQ?=
 =?utf-8?B?YkRVRTJlRFNlS0hWZG1HekgzVUZkYUJyRkNEQmhFcE1JNHd0U0ZSOUdjak9w?=
 =?utf-8?B?UmNRT3gzMW9EY1FyRUExaVgwTHVMZW9ZYXRMaEo3RWRod2M5dUxwTTRDNC8v?=
 =?utf-8?B?dG9DTCt1Y0t4Qlk3anVTWmJUS3pJSTgyYmN0ZXVlR2tOQnFTYm1EZjVvZXRM?=
 =?utf-8?B?dlZEMGlzUUU0eGREbFBDa04veWRlSGpyenl6WkJxNTAzSUtZcWs5R3BkMDhG?=
 =?utf-8?B?SG45bTFobDJlNGxqblhwemd5cGE3NmNQaU9DR0F0REpMRWhUUEFUMzV1Ump6?=
 =?utf-8?Q?bS4i0MKJ897/BsqigC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affe7457-8734-468c-9c1e-08debfa8db71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:41:49.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9KDBj3xm18xKxHFF37SuQcHNbIsgrE5xG43ts3rYfFptHEmwliTWfk2I3rITEwOl/LZDzubMDxh3Lu8K8dUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905

We are pleased to announce the Call for Proposals (CFP) for the sched_ext track
at the 2026 edition of the Linux Plumbers Conference (LPC), taking place in
Prague, Czechia, from October 5–7, 2026:

 https://lpc.events/event/20/sessions/270/

This microconference provides an opportunity for the community to discuss
upcoming sched_ext development and outline future strategies for improving
integration within the Linux ecosystem.

Topics suggested for discussion include (but are not limited to):
 - Hierarchical cgroup sub-schedulers
 - Integration with SCHED_DEADLINE (DL server interface and related improvements)
 - Proxy execution support
 - Device-aware scheduling policies (e.g., GPU auto-affinitization)
 - Composable schedulers and reusable scheduler libraries (leveraging BPF arenas)
 - Scheduling strategies for gaming and latency-sensitive workloads
 - Tickless scheduling and CPU isolation
 - Improved tooling for tracing and visualizing scheduler performance

Proposals can be submitted here (select "sched_ext: The BPF extensible scheduler
class MC" as the track):

 https://lpc.events/event/20/abstracts/

Please submit your proposals by July 24th 2026 to give us time to schedule talks
in advance of the conference.

Note that the primary purpose of a microconference talk is open discussion, not
formal presentations. Slides should be brief and only provide context. Each
15-30 minute topic is intended to encourage brainstorming and discuss open
issues, not necessarily to resolve them.

For any questions, feel free to contact the microconference leads:
 - Andrea Righi <arighi@nvidia.com>
 - Changwoo Min <changwoo@igalia.com>

We look forward to your proposals!

-Andrea
