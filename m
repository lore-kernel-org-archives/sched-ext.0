Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD825BEE8
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033022; cv=fail; b=pmUPqAbd8iI1oeA2rD/chfq9zNnNeNw1mlAFGo2F3TTAY8mNF9+gxJ+kb6dQ1twceVwIsJXmM686ZZUdWNdXGBBnkGA/vqdp6FnH2jZihS9NHbmW50DpJNJXgKMWPmbbHxp4jQz9vNRMRSsWNKi1HqoMoIIRZVJCsPLoxnO8V3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033022; c=relaxed/simple;
	bh=EI3A3E4TXYNjanK9slaPzFMW0KVNUtI0rfrZKoxMEdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LHzvxCS77pcgzA2FZ+z/nq2o63t32MaxT4Zh74nlRCAyNhtxv+UYaNfeQ2CabpNLggHw9bz51OD3i8Ge1YuGKyLwKCMaOuH/j4Fx5cB4zjx4QOKkjX/M8BkfoYYjbrvVLhwNUU8Nfma5Ydgf2rZMCgHlhuoM144Dt5emh9d/FBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZkCqaZWW; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZkCqaZWW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa1w4vL/kuA0/b5NY9W0xWjEr7R8TBbS4J6KFXQ2VqrkW79aink5t+zFHjlpQIjdGzGcSXkxwhjsJeD5nFN6adFFDMIm7/VVEGR3FYTRbACdHLDg2NZUC9KBYEVjZgRd3YekQUZh39tD9x8lHQ6Ir3VYnLYRI7ryX75AC0CY1gdkiuaCD7l8XV9NRLBBkfnAZ6L5NI6axbNfnqIzihXGEINF0qXKBF4U9HtYxv8/QCl1u5gtgCe49sx4+JYPLzxlItSQq+lOMuXEaXzd75A2Mnw5Ds79k2UEWjwSxWXUGFYxSuTAqLuSN5sW/+4CI2rmWj8PATjmPZda12kzsK4BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcxvVXA6bPXDIPSZKfaPb5OYMkfEjxLp5C5txdyYvWM=;
 b=WS0RBjeBYPwz6G/8Y0O2YoojjZVT4xgIyumLTY9w72+SNdkE+oRKmbv8ih0STz9yfOFkavipCeu2q5NpMMjJ8tjSRlLBlzZms6C2lN/D0PHzuc0f5P0L2HfPwJ+NhagkJyBk35lwMG3sVzwGCGZ4lMfmiqvEscxoYgjiVAMrQ2n6ArZWkLuVSD/VGO2EntotNyofZLcD8qxKH1K1+4gFB4n+Xkt8UqwbHeVRPDWvAHRKBbDJplaMtEH4w0XkvKnK2ieq3dpi6VMvhSuQr8OyO/y+CSkqzI5l8Zd+agKgH6W0yW0WNZwrq1MpH+TNnrWAp4m0G3XZkOf7vom59Z/pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcxvVXA6bPXDIPSZKfaPb5OYMkfEjxLp5C5txdyYvWM=;
 b=ZkCqaZWWooF3FBHECNExcJJM+vwJVuvf4gvCdtBVmD1QA3n6k6qn89UWKsBEq7tdIi1V+3yxRyO96tnxj8BpYnLcvh53dUD6qadlMkk3ZF6vSxRBXhRPPJA55vvv8pv4hiJrknTRgdrrH1qkVWGYqbvAi71KuOYXWehUvV/MKf2fxuI9MfyUYWe9zUBcGEmJI4ffnhpekQ/g41MlipjBjMwCczn+9sFb5nqmtj5Zgj/Rgvem1plu8sDBn+X6SRCwGb9BmFqooDXGUBVj8/B3KTgUScbg0Y/pvR66jnKBaCVO7MRckuMlkrKm5juZr3o8BawTS/L1GUwI5WCBM2KKYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 14:56:55 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9388.003; Sat, 6 Dec 2025
 14:56:54 +0000
Message-ID: <c31bc7c2-52b4-4a91-ae0f-259411145432@nvidia.com>
Date: Sat, 6 Dec 2025 09:56:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 kernel-team@android.com
References: <20251206001451.1418225-1-jstultz@google.com>
 <20251206024724.GA71744@joelbox2>
 <CANDhNCoe21MYZUmOoa7G0ecU9SJKTFtEp-LjOJXAsCj-ZpQb6Q@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CANDhNCoe21MYZUmOoa7G0ecU9SJKTFtEp-LjOJXAsCj-ZpQb6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: efc419b6-3a9c-4001-ebd8-08de34d7b1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUVuYkZSMnpJeVlQWWZGVFJjaU1VZDZFMzAwL3pKNExMdGlZM0FqNHpHbWNi?=
 =?utf-8?B?c25MZlY4ZHEvamFvS2MvUU1RUlcySkdDYmNFdzljL2J1cERqY1dibkpSYW56?=
 =?utf-8?B?VHFodDBZc3FJbDZvcVhKdUtwQ01ONFZYdkFoYXNnbmRPT3JraEZlQU5KNnlF?=
 =?utf-8?B?Rmo4eHUxdGVQZExtZ1kxMXlZdGc1dmVlTUpFeXpHZjI0blA5Z0YveHp1MFgy?=
 =?utf-8?B?QkRnVjlEcTB3Ty9lQWdXcFhHSFJxVWRYR05lRHIyU2IyQkl3V3BVTFVoS25h?=
 =?utf-8?B?VjFtditaSUdKL3M2RXpJckN6enZQQktlTGZFMjBla1RxUU9VRVV3anhFa0dl?=
 =?utf-8?B?ckYzN3c2Z05GRUVhczJJNUw5RkNFM2xZMlNXeU5nK0dkRFI1UGl3dDd6OE4v?=
 =?utf-8?B?VUc1UElCL3BqQ253czNhL0s5WnJrODFGYXZjSzAzNUFxc0tyMnE2Q1VCSXEx?=
 =?utf-8?B?MGt2ckN6ZVJhQTB5SFJ2dDhLQ0xoeVFDMTNONUpCdG9zcDVTOTFwWVVSTm1F?=
 =?utf-8?B?dHBpaVMzSjBhZEdYdFdOQnlzRTFab1FaeE9iWDcvS1lsSlBEKzdDbDJqVDFK?=
 =?utf-8?B?S2E3MFI4c0g3V2xldGlrRUpVSEtaU00xOHpiKzdxeWZpRjdpSThrV1RiUE5z?=
 =?utf-8?B?NnF2VFZ4UkRrS1hjdVpFeng5QTFYbnZWK3htSnNhRlY4V1d6S0xhZHdJOEZL?=
 =?utf-8?B?M0J6LzA0T0lUckdxZEhrQkhpSnRJdzZ4WGZNek5HR1VqRjQ1cmI5aSs4TkpU?=
 =?utf-8?B?cXFpbDQrbjRPTUEwZkZjdjhUdDYzZnRkdVpTd2VKMHRBS0tiSXZIcXlaWkIr?=
 =?utf-8?B?bHRYdzB5bllZd1ArSEM0RHgvR0ovR05LcEtkaDdIMll4NFpSMllVYXpEUytO?=
 =?utf-8?B?VXp3bFBrNUdnTzhNMGxlUEFidEJhVXAycnlybUc2UXhyNmpUV01LOU95c1Vn?=
 =?utf-8?B?d2ZxVjdsY0xYWTdKcEZ6cWErQnlFeVBsN1J2eGQvQ1FJMlNyZDhYZ1VrOHkr?=
 =?utf-8?B?eUJsZHhvaEV2SU9WbFJocit4anhWOG1kc1AvdHNDSnF0bVFxajBZZnZnTkdw?=
 =?utf-8?B?U2JDY1l3cm9yckJVSjRhRVhhSDN3aW5PNFE3SEh2ZGZLZnNsSytrVkQ2ZTNa?=
 =?utf-8?B?emhDczd3QmxjN3ZwWlA4NE5vcmx2Yzl5MzRIOUgyY2tNdk44eENDQkttSVJt?=
 =?utf-8?B?SFQ1RE5WdWJNbDFicXpORWc2bTg4cW9lbUJzWDR2d01rcG1YVkZXc0g1dDM5?=
 =?utf-8?B?YytRRm50dHliWVp6WG9ac2NUU2JVMnlqY2czQkZrYlI2K1JOSDdjNCtXTWhH?=
 =?utf-8?B?eU04cWVRU2FxODBKNEF5d2g0T1YzRS9PYkZvUEthMFAyeit4aWlzeFdkc3JR?=
 =?utf-8?B?UkpCU3lncFBFck1DWFBkOUgyM3VZQmlTai9RMHdybjhFS2ZQSWxXUTZXdEl4?=
 =?utf-8?B?UnQvZFlSS0VBZ1JXMWVJcDkxaUF1aTFML0ZmMXBYcW0zZjIyTUowZzFCMStB?=
 =?utf-8?B?bHFucWFONFdXa3R1cUhPaE1nTXozcnNQMFdsQ2xDU0R0QXdqNDNWZXgvTzlN?=
 =?utf-8?B?U2JaNTdrRDExQ3FEb3ZNRDFaZVlPektIWXhKVWM3Z0t5VFZhczQyWG1KMzBr?=
 =?utf-8?B?VDBiUWpLWnVpK0xhdjcySTMvdU1PNldsU05VOFU5d2tZWFMyQmdyWWdYZEtO?=
 =?utf-8?B?TUpzd0F4TkpubW03WmorYzFlblZoL2FlR3d4aWRQS1JMYkJEUkE4TkEzVHZu?=
 =?utf-8?B?MWRHdHpVazBacUFHNWVtWGtTSDgyS28zZzU2c3d2djRxV1NHdk43U1lDekwx?=
 =?utf-8?B?ZEV6M3lCMFQ4VkF6QWY0WlMyd0dnK0pxUktjdUNkdi8vOVRsM2hqUG1zRUUx?=
 =?utf-8?B?RG11d1JhM3N2Z2psRkFIMlJjSFdBTVdSYnBoUnZORXdrYklqTDdtdmFITVEv?=
 =?utf-8?Q?fUOP5UkjxqkyprYSfmelmX0KgYRuTqTF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTNoRFc4cE8rQy9QYmw0Z0tTOC9ZRVExYWZRMU5LTEJpZTY4Y2lxM0tPK1Bz?=
 =?utf-8?B?bUtMWnZGRXJWVnZZR0psdnh3T2Vsd1hXZCtRK2V1M2NJLytnMzVTdVBYL1NL?=
 =?utf-8?B?TzlabUNXbFJHMHVBK3o5bjNnc2Vpa2RFRms4OW1pRUw1TE9ZYllQUGhIeWVq?=
 =?utf-8?B?WkxKUzJkenNDM0lWUEltbk5hU0p0TjMwd0JDWjE1RFlRMWhuTzllK1VyZTZo?=
 =?utf-8?B?TjY5YTl0YWJscnpQSm11a0hyRTNOVUc2TEJkR2lvbzIwT0dPOEdSL3Z2SE9t?=
 =?utf-8?B?K1NZVDJ6RE50UFE0VGtGcFg2YVZuTzVLSG5ubGcvNzFNcWRVV0dmazVydlV3?=
 =?utf-8?B?NnRqQlN5L1ZDbERKK0M5Q0E2VmFvN2RMR1VUODk3c0g1aU82QjFjdTlxMHhD?=
 =?utf-8?B?cE91enpZVlJMd2V3bFdRV0d3azhkd0QyTGQvdGZZTmlLRmZKNGJtYmdyVEZY?=
 =?utf-8?B?YzNXMXR6NUhmUVpFZkRNQVpvNk8xVlNTVFhPL1NrN3JSSjNydXVxQlovM09P?=
 =?utf-8?B?ZVZvbWtnYkJPSFpEWXY3Sllkdlk0MWVvYjZqU2pOUUc5ZmlIWkVNMkdPVWpa?=
 =?utf-8?B?UkdDYnVmakpINE5yNWZsOWppMkJIVlorN1VENS9KWnNxcHRKNFlPa2tpOG9Z?=
 =?utf-8?B?YnRQTWhGbEdhdCt5VDlldzdLU2NLWUdra3ZzQTBzRktnMHBZVUtlOEVYNFpQ?=
 =?utf-8?B?ZHFEZlh3L0x5cXZ5LzQvL1BFZU8xdlRWR3dqSnhQUGNHbHYwVlh0em5BaDRH?=
 =?utf-8?B?R3BzTWwvNm9jOGlCQXZ6Nk4yV2Y0THdDMXhuTXdoNmtrVlBIZEs5bEUvaDZE?=
 =?utf-8?B?OTZsZkJYa1ZKMUNKOVR4QTRMblJubkRtSUkyV09yL2t6cjBiaHZwNGJ4UHBp?=
 =?utf-8?B?Wm1JTS9zMExkTnNIREZjR0tETmhDRVVSdmxpSzV1VjVWcHJCZGhVMFJ3dGF1?=
 =?utf-8?B?clo3S0ZIeHBpc2dPbzh1UW1KSllDTy9sdTZwS3E0cUU2d0o1c2pjWkVzTEFJ?=
 =?utf-8?B?L1l5SnFSc3NjWDU3MVliUWY1TWRvVWlvdXZnTmYzTUkyUmhoZkxhKzJNSkZz?=
 =?utf-8?B?dnN1UitBSjhBWHo3Rm9RTk1iSTRzYWZGeURkRWJzZERwbE53MGhVNElXbnBR?=
 =?utf-8?B?OWpXRFNqMXVTc3VkajV0Q0Rmb3BWaUFhZFZlWmxvdkEzUTh2WGdrZTNWZ29x?=
 =?utf-8?B?THIxc1Nvb1IyNnlFc2pDRGtIWjBUbnZ0SEp4N2xjVG5vakVGazhYTk9laTdz?=
 =?utf-8?B?TUZkTjFOTldyZmZDTlI0WVl3SDV2eHJGbUJnRVVMcGxzNCtvMDJjTGNwZ0U3?=
 =?utf-8?B?UUR2SmZuT2hVMWppZ1VJNTJpSjdRaGxqY2hwV003Z0dnbmJoQlRiejFRWG8z?=
 =?utf-8?B?eGF5Y3R6MUk4bXNnL09RY29RcUMwV2JHSXNmRExwTnFMTzNPQTZOOUF5Umwx?=
 =?utf-8?B?dlBsREVHK2R2UnBOeWtGYTQyeFdaU2dibzNoZEJhbk1BOGdWTTVSRkVKdS9E?=
 =?utf-8?B?Qm5GNDVkT1pkRUFlY0IvdUNNVFVZem5ibTlKSyt2anI2eHA4ZzZvNU12MFE0?=
 =?utf-8?B?K0FDblVCb2p1aHpPMTd1djd3ZnBDckNFRlc1d29jbjRiem1sQWN0ZWx6VUsv?=
 =?utf-8?B?L0cxeUZjWkVvUFBFWFhBWHJhZ0wxWW5aUjRnaCtpK3h4elhGMzZoR29rcXlU?=
 =?utf-8?B?a0t3dWd3cktYeDFhNTZ6UU8rMHI3cFJad3dadStnT3kwaFhGaEpCTXBGZk5R?=
 =?utf-8?B?TllwQnN0Zk92SEZ3OUlkdEN6cVRNV0xaZ0ljZ0srNmVJYjZXRWhSYnh2NkFK?=
 =?utf-8?B?VVo0NnNJTDlaWTY3ZndHNldMWHpSY3BLc1FQU3hyUWk5ZVNoT2xGR21ML0dy?=
 =?utf-8?B?R3ZvRmY5bS9xQnJiSEF4LzBXWis5SGxENlRBU0Zhd05Edk9ZZ3JkS3JYbXhw?=
 =?utf-8?B?QjdDT0kwMHlmTi9UQWRsWC9NWCtzcmNIQXpRZ29QQ1YzWUhtWUhka2FaNlI3?=
 =?utf-8?B?dEhJeGxzRmxwMk8xMHIybS9Md2ZGYWV4aFF1TUlaRmRWSUlGS21KL1hmc1Zj?=
 =?utf-8?B?ZXNIVGZ4MFdFZjFYUHFpYmlyRU1wU2Q4MWkvWFNZRWkvSWdYT3BIeWErdUVI?=
 =?utf-8?Q?FDmwlpI3+DTtvn+j3X15iDrHU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc419b6-3a9c-4001-ebd8-08de34d7b1c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 14:56:53.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnSAyQ/H7Z9/dBld3S1/h2Im9AinrKdow2Ok+bw0QrdkEbNMXiYNQZ3kCBVWyNwK84Lbjv/3lUCDePG79sMaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529

Hi John,

On 12/5/2025 11:49 PM, John Stultz wrote:
> On Fri, Dec 5, 2025 at 6:47 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
>> On Sat, Dec 06, 2025 at 12:14:45AM +0000, John Stultz wrote:
>>> With proxy-exec, we want to do the accounting against the donor
>>> most of the time. Without proxy-exec, there should be no
>>> difference as the rq->donor and rq->curr are the same.
>>>
>>> So rework the logic to reference the rq->donor where appropriate.
>>>
>>> Also add donor info to scx_dump_state()
>>>
>>> Since CONFIG_SCHED_PROXY_EXEC currently depends on
>>> !CONFIG_SCHED_CLASS_EXT, this should have no effect
>>> (other then the extra donor output in scx_dump_state),
>>> but this is one step needed to eventually remove that
>>> constraint for proxy-exec.
>>>
>>> Just wanted to send this out for early review prior to LPC.
>>>
>>> Feedback or thoughts would be greatly appreciated!
>>
>> Hi John,
>>
>> I'm wondering if this will work well for BPF tasks because my understanding
>> is that some scheduler BPF programs also monitor runtime statistics. If they are unaware of proxy execution, how will it work?
> 
> Good question! Be sure to come to my LPC talk on this next week! :)
> https://lpc.events/event/19/contributions/2032/

Sure, will try to make it to the talk and hopefully no conflicts. :)

> 
>> I don't see any code in the patch that passes the donor information to the
>> BPF ops, for instance. I would really like the SCX folks to chime in before
>> we can move this patch forward. Thanks for marking it as an RFC.
> 
> Oh yes, this RFC is intended to just be something to open initial
> discussion for the session next week. I'm very much hoping to get
> further thoughts on it, in person, next week.

Cool!
>> We need to get a handle on how a scheduler BPF program will pass information
>> about the donor to the currently executing task. If we can make this happen
>> transparently, that's ideal. Otherwise, we may have to pass both the donor
>> task and the currently executing task to the BPF ops.
> 
> So, one thing about proxy-exec is the class schedulers are pretty much
> are to keep their existing behavior. Its just the core scheduler may
> not actually run what they pick.

Didn't we have complexities with RT, push-pull lists and such? That was class
specific, no?

> That's ok, as the task they pick becomes the rq->donor that we want to
> use for pretty much all the scheduling accounting (the exception being
> the cputime accounting necessary for cputimers on the running task to
> behave sanely as well as top output - as you have helped identify
> earlier).  So this patch is just shifting the class scheduler to
> utilize the donor pointer instead of curr, so we are consistent in the
> proxy case.
> 
> As for the concern about communicating the split context (rq->donor vs
> rq->curr) to the bpf program, to my understanding, the DSQ abstraction
> seems to make that unnecessary. It provides a general enough interface
> for the bpf logic, that it seems we only have to worry about the split
> context on the the sched/ext.c logic side as it processes the DSQ.
> That said, I'm no sched_ext expert, so I'm hoping at LPC we can find
> any edge cases that do need to be dealt with.

Right, so it is exactly these pointer shifts I was concerned about. Runtime
callbacks such 'stopping' [1] directly use p->slice.

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c#L124

So we have to pass the correct 'p' to these callbacks. Did I miss something
about your patch though that handles this?

If this is indeed a problem, maybe one way to get around it initially is to make
'proxy exec' an opt-in for BPF schedulers. But then we'd have to handle a hybrid
world.

At a high level, my understanding is BPF schedulers have a lot of say in how to
schedule including precise time slice and preemption control (give or take level
of control and performance reasons). You can in fact have your own 'userland'
queues that the kernel is unaware, IIUC. I am not sure if proxy exec will
transparently work for all those usecases. It will probably work properly only
when BPF scheduling in userland is simple and most of the scheduling is done by
non-BPF kernel code.

Maybe this isn't a problem at all, but I thought I'd double check. :)

> Thanks again for the thought here! Always appreciate your feedback!
Sure, any time John! I am glad to see your patches continuously flowing.

cheers,

 - Joel

