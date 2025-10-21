Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F9341660
	for <sched-ext@lists.linux.dev>; Tue, 21 Oct 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058672; cv=fail; b=WwIIm3IMXPIIX5RfAdhI8xrD+AuQu8T1dVo6VvyP7tW/A+nE0pV4oanlhLj6RigDvL7McanD9M+HBdHgH5c4mxa/6GE5cDni5VJtaxLIa1gAgtL9eygyGDE5yFAQKovVCQyopwU6M9G33CEyzAU1UZTKOWim+LM7lvRrDEmvkyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058672; c=relaxed/simple;
	bh=vPXfGi2jSWCI/cr55xLYpACw+9ziSEZbPKxQUlOcy64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keF5f6X5ipVTIfSHcPJGcWcFrWnaV4fVWyWGQ6uZqJhg58joalAl2FfxSuFtvmMrteF9sGiM/kzWRM8w7PvhPChWltz6Yhp6GMMWuFwhEUZuaWY7o91PHAbi8CaGcYZPupmVdHUuZ64FP817EZMqW6rybHjL7pHZnJW/IPsxJ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrjJPvwQ; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrjJPvwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNIOALwZFi1PrnZh75l71B6GtF4Ha8LiuqzHq6sGUsAkpzlQ/0lqHrQFUpgredQeQjAhkCLhX/mBg159f6e/gCQPSdbKuGlzmdik4gdn8gcJEy6gBluLC0pJQt30Kq9fAsDz5MWjVX986MDIBvw12mfHw/RDNe8a6yf1qqbsXlZr/kICJcmX9Nh5YLMons8Cs+3s0NpXSJhxNh7xj+Me6mio2Cq/HejbV+hfSovU8SSjiLC8vgHK9xHr0NuH+pa4uwy+ev49X1/qlwOLChJzpnOfMUb5Hja/wN2u0lqca79SLXsaUMfoz2vXRbkCbLI4lzTgM34Wd9cv7ifA6U5snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg0KjvhgJSnlwF+E+WLud6ShMSnTF/0z29fgNRjIFzU=;
 b=iIe1PamS8RZ/cFfubL2UAQHCEPP75p5Gxm2AzEOWH2as4mD4f5rJsGJTk0cBmgT78e3FbvmMqxtHO5yh/lqqp5SbhgXx4cu7ckFssnGzMxTnlgOBVqtO9gJ+8awPdeBbKO78kAPasd9AwZJ+tQXytaQ8xoBaGntMOchuoyROH7aWrRDbC+tZbJyjzs0KbTjT606l3bS/uwA7QKgNY0ei5RgU+NA3vfOXeRLFjEcvYbdI1Vz6UvIdoLM+ULTSaOnWIVub70I3WwZgAfz5Hq+wG4oKw8QMHrDNmG8S9b+5QQY18XOAZPaTSFQTbukuBoO17E/I/e24tbVBSXvWpgqKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg0KjvhgJSnlwF+E+WLud6ShMSnTF/0z29fgNRjIFzU=;
 b=mrjJPvwQUtz+D7SZb6Dcq1VtmLhUdk0JLM2GdJwWYXAGzE24lYbGXZP2lbqQwifuO+cuMqXrW8ZZ62bJiz3moSV2852Dbk7GND41lrbLehN8duXh8CP3KGEPXvhpDqz4OZyyJnxWgMvDpbBMcA3gMCYTUkLgtFrhtk7F95ahR/ft/u1E4wjijSvQm4cNL6/Np9sZ1NVAumRy37QiW7ePB3/uITLoT8CN1XQ51EcriCq43M62Qi8BOgyGpgMJmOl028ES80qUbQ+9R6UlDntcVOD3wA/Z4MQJ/306scgF/T9WprNEDjGkeIJFfqYP7yV1ZOUGRrB9WNLpSngCdzOOnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 14:57:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:57:48 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched_ext: idle: Reuse sd_llc_shared->has_idle_cores
Date: Tue, 21 Oct 2025 16:55:44 +0200
Message-ID: <20251021145706.61534-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021145706.61534-1-arighi@nvidia.com>
References: <20251021145706.61534-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 864e9c7b-9a72-4fc0-c3b8-08de10b2334c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXFBS3UwZlVmNkcyT0FIMkQwdGV4QkhHeENoV1lZcVh4YW1MN2llZzRmZkJj?=
 =?utf-8?B?NDBvb2p5T3pyaFRIeXVpazc1cUpieDJPdk9yR2JsbnM0OEtLU3l4TDZKc1lk?=
 =?utf-8?B?RWpNM1RBT2wySUI2VUxPckkweTYrK2pZbWljVmVvSURKQ2Y2QWFoQWszcWor?=
 =?utf-8?B?c0M2TFRTL1FPOE1laGN3dlJPZWEvN2xTOTNsN1h6dE1majRJNVE1RGV6NU4z?=
 =?utf-8?B?QTZieUZqYlVaeUFKcUE3cVF5a1Q4R2xvaFhybjNPd1VxUTNvdFRaa2lmV0Zj?=
 =?utf-8?B?eURJQXdyRThKM3V6MGNRT0RNTC83QnNrVHYzTXIwRHJueURleE5Scms5d2Q1?=
 =?utf-8?B?SjQzZUdZWE5TSTdVTi96a1ZEUUE0SHVvaUVueExTMjBnMGlJZkI1amdmK0tv?=
 =?utf-8?B?VHBJMEJQaFMyWFZpbmh3VW9IQWxPTGpMZmNoVHRyMm0vUVMrVUNTVlRxZ2sz?=
 =?utf-8?B?OGY3K2FSdldab0xoczI5UTFlSk4vWHVDVzV1NlAwQXpBVWpMQXl0eEhZYjFW?=
 =?utf-8?B?cmh3cjFCMDhxbEs0dHRtVnNlb3JBZDVlTEdIZ0VOSFNtdHpBeWZheVk5R1Zw?=
 =?utf-8?B?RlNoVjZZeVJiYVhERTFHOWIrUWpmcHMwSEpSWTE2WXBSM1ZiT0x6Yk5EMXpr?=
 =?utf-8?B?TmlLMnFsZEZKK25LMlgvVHVtVHBBRHRtZExLQmp0Slprc251UWttT2pkLzdi?=
 =?utf-8?B?ODVEZVZ5TmdtemlJcklZUlh4Ukd1S0dWTmZtMnpONHpIRUp6Nk1VRUlGYTM4?=
 =?utf-8?B?U3NZU3FjZlVGdElJNG1meksvUXRRRW5YU0p6SVBMYmZYWTg2TVp5U2N4c052?=
 =?utf-8?B?VkF6c3dqU0xTbDAwdjk1bndHK0RhdXZNcGJueDRrNzhWR1hMUmNjOUlWTEtW?=
 =?utf-8?B?YzBQT3JuM2FpN1ErK1JHUGJGUVFESUFESUxZRkRrYitmM1lRSXFPWVRWcG5X?=
 =?utf-8?B?cmU5dDVtM2F3TVpNaGh2U3E2VTY2UjRjdjVlMzZqUkFBWi84aE9MeHFlTGZ3?=
 =?utf-8?B?dkZKQUlVZlZyVTFYOG1aUzFwUm9BQnVTalM4ZUdJYUtCMGFKUGJYWFBlaDli?=
 =?utf-8?B?bHFSSjZWdEFxMDdIK0xXSmRjenhrOFBjbjZCOGJrWUszWS8xZEI3V01aVlFZ?=
 =?utf-8?B?OVhWZGU0Z3ZsVXAwSUJsdzRDZGVENWlVV2w3OUpIMjc3aHc3WDlKSFhZeGlk?=
 =?utf-8?B?aGRrbUI1N0pHU1NyR1dEcE00c1Z3bFVjMkN4Yy9YcXpuYWdFWXhzclZOUWwr?=
 =?utf-8?B?VDhHbEJYQkRTbjdUSFRKZnNvVU5rcllQNEM0OXA3ZDlNR2lEcUg3MjFNaEZ2?=
 =?utf-8?B?QjNEMFIzMjhIOU4veFZEelJZQ2ZPV1cybTY3R1pMQjB5K2daR2IvMFBCRVp1?=
 =?utf-8?B?azl1UFBCM2RENTV6YnRhTzhZUGpQVUNHa3dtK29aeTBoR1Q5RTl2b0p1aWNn?=
 =?utf-8?B?bTVlWWk3SVVmNGkrTllVYWlMRkNFMDVzZURUWGhyaVkvTWRyVkwvTGhqSDZj?=
 =?utf-8?B?ajRJak4zZkNTRS9CaC9rWGs0QzdpdTdHZnFwL2VDOXlPTnhYeGJKRTBFLzZT?=
 =?utf-8?B?QXl6bmdlc1p4cHNBdWtvaHdWWjlwSnFzMUh6cmUyN2EwTDZ5OXpZQjl4eFVI?=
 =?utf-8?B?RjVrYWxLSzRDRTU5OXJXYW1yR0pCNU1FVk4rRCtIYUNTdHhHSWppREVVa2pa?=
 =?utf-8?B?U3dYQ0hpUHNyR2QyUkdWdDNDN2x3SkZ3Q2M3QjZFL0l6R2p1ZkNHY3VoTG90?=
 =?utf-8?B?WHRrZkRPMGVHK01EVnl0Z2RJdTNhem9zdjRNbDMrTzRQQW45M09FVW42N09E?=
 =?utf-8?B?VzAyc0lONlJCenJBajRENE5PQ0p6TTZUcWpQWWhXTUlvWVFtZUlBT1ZSbDZL?=
 =?utf-8?B?MWZKMHd3ZUVmTHZEU2RRWFFmYzlXdGFGTldHZGVGVittR3hxWjdEOElGT1hB?=
 =?utf-8?Q?pJdbjPLfwwZcfkiKV08o7XPdis/XM+XW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZKVnZkUDI2bzllbFhmVlVSWjB4Q0RNQkt6Z1U0Q3FJWHh2OXM1R0MwZDJM?=
 =?utf-8?B?bmZxU1B0WEs1Vm1pZGZHZnJsSDUzc2pJS0Yrc2owSXhId1RGaERaUW1ZUVUr?=
 =?utf-8?B?a01TZUdsbUcrN3Z1REVuSk9iTkp1TDZrTHFpWC9odVRZcVBRZUcyMjBqR1o1?=
 =?utf-8?B?WjcwNjhobFE3aHFKSENtS2doRkxweURkT1ZLR05UbDVEb1VSbU9QZUxhekI4?=
 =?utf-8?B?L0JyWWQ1cWI3SFVwZGFCVVkxaGZPN3pjSFFNb0tlUTUwN1dVVzAzdmh2VjdQ?=
 =?utf-8?B?dWVWUkdUVFBSS05nQVBKNGZibEtKQ29VZmlQOVc2b1BlQmZubjZ6by9MaGV5?=
 =?utf-8?B?d05vbFVWekp2c1RoM0JnWFB3UCtScEh4M1g4VDBJWUx6K0I5MGV0RlVBd3ZV?=
 =?utf-8?B?ZVJ4c0t6d3MwZWhqS3JrTjJxbHVxTGV5c0ZZTFEraXkvb3lQNGRxR1ppakVz?=
 =?utf-8?B?N0ZIdllqR1Q1NTRhNzVuMjAwRnl1UC9TNGJ3VDBKZnQ2eWMyem5YOUFTQWda?=
 =?utf-8?B?aUQ5ajIxdE1xalIzckVLK1JaTlFLN1JJWVhBSm5rRDA5NVlSOXBDaHlTMysy?=
 =?utf-8?B?T3RlV21DbldmcnNmTlVQT3p6N0t1djhTaFRNeERTMEdFbGM2NXBJNUQ2VEx5?=
 =?utf-8?B?WlNHNkJ1bVFJNmpwNUlVUVJIbmJIcEo1VnJnSlU1eC9WLzJYL1MxaGxneXV5?=
 =?utf-8?B?U1U5OUZFKy9sOXN6Y21lRS9aZEFOOVRzeGxka1hEMDVZbURZWTlSYXI3YzB6?=
 =?utf-8?B?MWRHUVBwNFhUSEVVekhrK3U1NHc0ODc1dnVjU3Nrb0JmMEtpaURsL29QbVAv?=
 =?utf-8?B?Ni9RWHp1RmxCUWZNMG50T0QzK3pVaFhwZFc5bmVTZitEbGxuUVYvNkF3SWl3?=
 =?utf-8?B?cDYxZXZWUExLNmp0eGRLbVd3OUZaYXFubHVjQ1NEdFZMVHFJZ05ZNW9tLzI0?=
 =?utf-8?B?MFM4TGVQenRnVFRWOHorbnk5WTBVWFFHb3U5WVJmU0RhRkIvN1hSd2NhMERH?=
 =?utf-8?B?SWx1b012cGJqbERDK2RXUU1wc21YNVBsbjR4U3FFTmVLQUJZcXdjOHVBckJl?=
 =?utf-8?B?ckdudk4xWTlXQ2NpVzdHaTFJbElhNGN4OS9QOWE3dVVSeHg2U0M2ZDV5Vmht?=
 =?utf-8?B?a0s4U09TTW8zbEYyOHl2UnF0S2xscUp1UjV5UXZXSEdvYk5NaWJwekVjeWFD?=
 =?utf-8?B?RWZFTkZydEFvSU9IUUdNdDdLK0hzcWRnaGdrS0lSMVZnczI3L1ZzUDhwbDVk?=
 =?utf-8?B?ZEFWRlRnZFJ3Ty9wWUMzQ3ZvNXVWVU5jZWlNM1JqbGYyWGtlQkFIYTJhcDFC?=
 =?utf-8?B?Ump6MVlWb3FjS0ZNZE00eFFGY011YVNRMlcrRnMra0F3Q2lXK0lXc1VLRFVs?=
 =?utf-8?B?dzVIU0xOWUJ1c1lRdFhjUTFDMzVzb24xdWtZUUlyMzN1MExzeGhPekhCVndh?=
 =?utf-8?B?ZU5aTE5KVHduL2VvcXJjWnVuNnIxVmZQTmZNWFdTYXF5eXZXVGJRWTRZYWhJ?=
 =?utf-8?B?ZllMUW4vRXB2MlRqR1Fyb2FFbHRMNjd0N2ZhdUdFSXFScm5GLzE3bXF0RElO?=
 =?utf-8?B?QVhCbnhmaFBvRTZCQ2hTWHdvS2M0MldFY3YrdDdCWVZtb0YxWENTb2R4Vy9I?=
 =?utf-8?B?U1hKOVU3eXhnV1k3ZFByanplaUJvR0NzaGJyakJKMHVBYjdqejQwS2hlVzkx?=
 =?utf-8?B?WVFXT3BuKzlXNW5vVGlkdDdvVWpyZUF0RjFXVmh2NXlLcGdhdVEyNkV0WitH?=
 =?utf-8?B?VFp0VGE4VVZxamhZTGN1WU5RVlVON1lZNzBSSVN6TGJjOU5OblgraU9QdndC?=
 =?utf-8?B?aERyODJ4TlBaQ0xOYmhrVWRia0syOTJhcFpJRUYyN3IvalI3QVBmNnVBQWhl?=
 =?utf-8?B?OXphcVFFcVJOZnVBMTZBd2NxYU1Vb09UeHAreFZuUmZKZ2FZTFArbWJmUmtJ?=
 =?utf-8?B?ejJlSUFtamxWWkpRRk8wbjF3NEIra0YzREFxb0xhTWFFbjE0YUJ3OStJQ0lI?=
 =?utf-8?B?UHNkYjl5RXA2aFdkbmJkMGZSOW91cXoyd0x1dTg4bE5FTWhtMS9DUlUwUDlE?=
 =?utf-8?B?QU9hVlg0L00rSEFnNGJsbFZsMURVN3pVRStCdE11amNzZ0hHbHUwL1VCUTlE?=
 =?utf-8?Q?0K9RGiKKiHMzE5RMTe4TO+/rb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864e9c7b-9a72-4fc0-c3b8-08de10b2334c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:57:48.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uknVmzf+4/OinmDY1vEdueHoISwbxU6wfDM1nxhkcvlWBI3TifzQrqKVYwot0l+yyTf+Bh745mUKfuxFbyV4NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

Rely on sd_llc_shared->has_idle_cores to determine if we can skip the
scan for a fully idle SMT core in the same LLC.

This can save some expensive cpumask scans by quickly checking the
cached LLC idle cores information.

At system saturation, this change appears to reduce scheduling latency
for interactive workloads, resulting in a consistent 2–3% fps speedup
for schedulers using the built-in idle CPU selection policy.

Tested with scx_cosmos, scx_bpfland and scx_rustland.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d2434c954848e..92a9a7edc2b17 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -558,6 +558,8 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * partially idle @prev_cpu.
 	 */
 	if (sched_smt_active()) {
+		bool has_idle_cores = test_idle_cores(prev_cpu);
+
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
@@ -570,12 +572,17 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 
 		/*
 		 * Search for any fully idle core in the same LLC domain.
+		 *
+		 * Skip this step if we already known this LLC has no fully
+		 * idle cores.
 		 */
-		if (llc_cpus) {
+		if (llc_cpus && has_idle_cores) {
 			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto out_unlock;
 		}
+		if (has_idle_cores)
+			set_idle_cores(prev_cpu, false);
 
 		/*
 		 * Search for any fully idle core in the same NUMA node.
-- 
2.51.1

