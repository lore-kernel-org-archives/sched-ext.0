Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E846EAE7
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764989253; cv=fail; b=kpL61VZegT3JzlKjWnOGOiftAcB0IQNu84QAJ/NlRu7aCUpEz/fXtAULIv7GxaCSoFMyLLfcmMs1d6SDqj9GwZZqPmSOq5LRA2MlXmKIczi4mIjFh67uI+pSbiB7lw85P/CoWfeJtBhHnO//QZ7++TpvlkRi5tN0X7l/EvsrA5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764989253; c=relaxed/simple;
	bh=+N9bzq7M4QdUmnq6yrbawZsdAccbcvpZ+dw9ETXoqkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZltkDdIoooNWppBx1VFBzGGvTmBcJNTKzbAjFZTDwIg83td3MueGtvWEwRDxPi+AEtdX8zHn2MWaXrBGRS2GBVIavtEE57eu/CxAxvHk6rIK3oLUWmEMy7v9Vbd3HVC7/JFck3EW+UB/0CpohuEnMmYjhC39x0rQAp0e6kGYE3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNlynKnX; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNlynKnX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1rvAaiwvgyFtKfvRCxFMa5H6crNvuenb7UGGWVRBtcs+Z0g/EG0lv/Xo5iR2wR+IKIGJV/HnR5KmH41bs6mTNb7iTXyD5bme+6qS3ysiaj2yI3eLr5hSsfbUF3UceHwRJska2l6nUYUsn7AV7qu/IJpFxGTs89N+C/OCwQLOtdm4Cg8+LoEKN1ZiADKNkd1p6oSlHFz2EtxWzsIwNq106h4DacOUGdblEKjvAY6Pb3Y0+mA5lAMFlw/m3NSPVpHOAtLWQYoJuhD1VRbGYTS5Xd3bU2C7WxggBkYjwP13Q14X0WxWAPPfophLIEPg2mQTIIa7rNJp6EUEfsi/cKxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC8wVGwGig1TtEYi2OuXzxmSJUBl8LUAT1hFhthRNeE=;
 b=iz/bqhshsUmazgQX9d/R6KONQmBK3vHhtaeSRDuLx+5Cq18vVypp0xqLazJVZSHThiT+GCHDBld0goV1pUyIBoyUegvKo7vI7DDS2TcPJXkmQeXJV9WaakAmKjYF7+Zr/t9uvmXf2ZNGWlxqGKQ37NPptDkX/zfv3Y+s4EYvLlBf0ABidfXd8W6CyLjsQQ/BSXJ2p6D4DZoc8z8RvMhY6PB27uWvwc8MpymfwwSHMggJ1wNzJQBSAR+DUoTj4k50VMa519hZcQ8rZzD8kVwIDvtu5AGlkD8W3Wwaiw8aViQuz8tIQVMDO4/E5LXju+7+Du6kVn4NJQatzXtsa5uhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC8wVGwGig1TtEYi2OuXzxmSJUBl8LUAT1hFhthRNeE=;
 b=sNlynKnX6ALJLGm5BMWfW1U4VvTDAeRnQKmjiaiO0BkqmK/HMy7ewf91VJ8kz9mk7/gjsZPCSSG1UQPoBbjgrb2QHDSqY99CS8+BzjAuFIZJB3c02OqhQcz8GDTQfgEg94tJdKPUZ/4DWL1zovgH6rm58pOWT+0wY38rvevXp3lGzVWbb39imS7RFW5jOVBPdSIm3nBU6TpYw+uhN3K6QEJ4uaM78ETwLGMmy1oihNXvUTYFDplCia7rL0y2E5vOxyHdlCyGMyh8WzRLN3F0n2+GoVYW/JSg5wNc+dX1uOI3RyeFO4KlebJ/MBhuc7917pVW19mtZRrFga5HyZ0s9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 02:47:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.009; Sat, 6 Dec 2025
 02:47:25 +0000
Date: Fri, 5 Dec 2025 21:47:24 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
Message-ID: <20251206024724.GA71744@joelbox2>
References: <20251206001451.1418225-1-jstultz@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206001451.1418225-1-jstultz@google.com>
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: a1021604-bb03-45be-89a4-08de3471c98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6UvbTwDdT8PQsWLEDtGJHJ5J4J3C4HLpnv9ymlThRQp5gY6wOyrYfAlyK5uh?=
 =?us-ascii?Q?kVt4kSMwdRQRXN295adMpf/AL/BsTBxmN9POGuIUmA3m9Dyrw4mRQBahT54w?=
 =?us-ascii?Q?9KpmSzWMtwFIOWmR0qd0Xt8XJVd7FFLz/4hxd1TRJ8jXlX2avx1GqqG2jcnM?=
 =?us-ascii?Q?8nwLeiy04vlTgTYXY19aXS2zVZW37J6FKK+HbNrbZfBXObcd3aByeYHMRALE?=
 =?us-ascii?Q?WC2V4OZFnsiLnMYshNHz1DrLEs/Uj/1Q17HlCfbQaH44RsiVlwy86bMHOBF9?=
 =?us-ascii?Q?onU5RSmLODmzgTZOY0yYBIzRioENzVo9s3iUSwvHQd/9JMMWwfwZkq1XK6U6?=
 =?us-ascii?Q?n+gs97V8k+6FSMJwEYpHRJ6dXy5rbwdh1l1CrH48XuQEEqTfpB3kzAbvBlbv?=
 =?us-ascii?Q?iUdHzBx45f3whwTFZjIDcz+UntX8JSZF37CFHmXeTDUvVbGAJXTtoIXfW84k?=
 =?us-ascii?Q?dY45dzpIPcqtsOoUfc6kb2Q3Ql/aJACWBi2WZzdspBDRTnQetzJ/McFm8wvZ?=
 =?us-ascii?Q?kl88sIUykzAXalucagRsihUPJx9nmpSs+lPX2FMRNlKa/a/A5yOGFWm1BGLo?=
 =?us-ascii?Q?UBvLfjf3qbukVqC137HrqioDCwCG7JUVBgPdcmLCAM9x8FQRGJE5/f0uExxk?=
 =?us-ascii?Q?XTt0GR1l0Omu3kOpPDgz7Io1ljO8JMBgjogccE95uddtV03FuaVDNVUUxn8l?=
 =?us-ascii?Q?NpafBd1rIrU/GilhMdQDrGtQi8PT4VLaCwUW7wBI3naTg/0IEg1g3BlMhex5?=
 =?us-ascii?Q?+jbWGnyCn8doAFFUCEW2dJKtA8XQViHvjSGKIklHv3KJhW+Wmu/wZ69IMdr4?=
 =?us-ascii?Q?zWXyC5QzixqGWobXi5nmOI/TVesW5RUoF5uu0OV/lx9mgSSefM2Qdd6+sNt7?=
 =?us-ascii?Q?jVsPgDbVvcvKXqQLR2d/HDeFbdng3OOJwXETFjtG7NUCxRzSHCieMFAayhdn?=
 =?us-ascii?Q?v0MGGWs9ompHQRFfHn2hcoUJzPILVvwy6EH7hoN9cYxGppCrAsNbuFkuRNH3?=
 =?us-ascii?Q?Kv7zKTTTC45ARQqQ91bPHRbAk1w0Wud7xqeQgM/9ltqnc4atCCWAkD+q5RNC?=
 =?us-ascii?Q?osZ+kuwprh9flelKYDkNyUb4VtZ6uTqwwHh2p7rmo64rRWAQsGjmJjqDRVmT?=
 =?us-ascii?Q?2BMBALUPhZOs1BoZURh7a7M6posSL2xIaajujiqVYoqDirLr7vMl5FEBqyyA?=
 =?us-ascii?Q?A7fkcX4FEZyOrjKn5VTm0FmDOOAeE9+0fNv0I5WqduNttSBVxS5yJ1VSgHqV?=
 =?us-ascii?Q?ts6pBUlBN2hgqJe9sA5NKhgRYS1kg1GHlvs6kesuq9eDVrufIr2/8suZFG0i?=
 =?us-ascii?Q?mJ46hQIrOIDfpScp6V5iQd9fjYOCg8yDjknogOW7h793hW3jTPjqxf1cFwbB?=
 =?us-ascii?Q?qgWai26ldS/Nr4R96HZufGHaROMh0ELtJUVAAvVlG2r3y+r1YM46ZTLnyZwD?=
 =?us-ascii?Q?bEBYGqk9lNdSHyosasb6Kn6CwVgg8SGI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?md7u9l5pexeZ6/kBzwRKOpbxuwDINemXlh2458uy5bvKUvu7JHYKb0C7qU6h?=
 =?us-ascii?Q?nlRpfSxC2Ua3vzSr2oOk0uvBsCieBnhmoUFwNErE3FK0vqdtGkEVly0epUyB?=
 =?us-ascii?Q?myQDh7yB9g9oWlviLXd/0NUOsOinVOWQyjFnWIUPfQFTPRin5tl30K/ykcp2?=
 =?us-ascii?Q?MM2ZVYq7CfDnDOj2t1gJDjhhN4Z0kkXUj4VOhJcsNKBmTPEnvOjPZ7afOkhs?=
 =?us-ascii?Q?8NlsazzuS60ffCWhnvOerPREQC/zFFjnFjxfETQs9kol+x6Kf3YEY6xGMHfi?=
 =?us-ascii?Q?qhPO4OvDbo5LF9q6BsaMqfWZQWpSO0O2Ie2l+JzpsxeMQO1ZzbRZdq9x9MkE?=
 =?us-ascii?Q?U4MFmgINPD8GRdgA0qbTCJ89vd6t4XpCIymgP3DfajIyRYAcUYF+m9R5lxgK?=
 =?us-ascii?Q?ND1davb+bfjoK8sXJegjNBLuxEMS1J2NIS7h/s1X2wdKdaZItxgoUHpIfB+c?=
 =?us-ascii?Q?AgA7RQDmxDqIfn4toWU3/Wk3kfCvs+5yvKPkXXRUFdn8cpdsbOToBn1THdAz?=
 =?us-ascii?Q?AUWxGsYoqvWzyJznyC2I5OxdljxH9Km8u4y4ukqhsU8GAYClk+z6E87rKrz8?=
 =?us-ascii?Q?pUb5aoJvJdInss2Pfj1LHGlyU9e5D4CThoIx0/AXt5w571dnFUC7ftil8zp2?=
 =?us-ascii?Q?X/SzEoMvyYpeGdX/7QM1Nxz/dCki0eKBkgkudkN0awe+ape0jZ8ooxQM9kgy?=
 =?us-ascii?Q?XugEc8RZixC0wKfyTE48qRfTWqpWrXTQ0XQ2PAXXmbPTsgysdOqdtBruHToB?=
 =?us-ascii?Q?0e8RrXADlpVHbOkIwSqoZNejWXXQnfj1QfC0g+87asCsPYWksJWE8tXX/u/F?=
 =?us-ascii?Q?UYweaGkCLqU6k2Wz30yYpBAl656pq5FAjchaxyYtQ0+45nOeTTyuWHOqMQHX?=
 =?us-ascii?Q?ORy4jSTkzE8okDE7chxZeCw+XIBlLsQKj7H5PkszCZlc1vG1lAsICAuZPDVp?=
 =?us-ascii?Q?fuCN7k5ZBevnjm1HgPSI2YIGwoHD8kQGHcg/BvuD7drjHGkTaMoTX7+/9ynF?=
 =?us-ascii?Q?5HOhwL9GbyAPPBQpEunKtrsZHmCRkEjN1xDqgJt9hxim+kl0ryrPkh7sXPa5?=
 =?us-ascii?Q?VwiwMnVdpyrZ0SxpJ9KCAItgYYpoYTijcdSkfU/wT/3yYfQxYcQiuvzl2gnN?=
 =?us-ascii?Q?hMbdVPurg4+R491NWS3/wa6bwSNQB2T/qQki1Kil7Mvk7BsuDNtYoB6TRYnL?=
 =?us-ascii?Q?eyVjtbJ1Tji0UP0770lQRrxa0Qav+A6dWENlYvKHFfS7660DVnC4730c9Oji?=
 =?us-ascii?Q?d5vgtapmJxRNitghGaozskmHgZEQbEItFen8+g4wsKSIWHNIUyFOlo7WDJ0+?=
 =?us-ascii?Q?+YLGR/fATd3POF6UtDfdrSqIJodmWB9XJF5AGaW40fByCG/DGa5C6+doCZtH?=
 =?us-ascii?Q?uXqzt4QpREGnOO7Eno1xH+afMYMjdwHr/QXlOn6MCdSnmWtaOUktIcV67K/B?=
 =?us-ascii?Q?awRM1dfYsfbtFhOUIs5d9idsrLWLYvlGNr8cJGBtK4upE0KlX3TojcXViqH3?=
 =?us-ascii?Q?UoGzeTct/mgJ7/g47Sh5YWZMKPdByUty/y52aNR8H4KwpkT5TMgvxINtF2zi?=
 =?us-ascii?Q?HViiJTOIROeyLA0p6DIYqozAbQ7nJSpmbdROGdrV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1021604-bb03-45be-89a4-08de3471c98d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 02:47:25.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72V7Rj6EE5uYadMCLUcrw+fErd/fo4ukKaKW2qkZ2qNoL1Us+OxtCj4HQqWJRSuQ3Y8AW/F9C/RahphcBSu5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

On Sat, Dec 06, 2025 at 12:14:45AM +0000, John Stultz wrote:
> With proxy-exec, we want to do the accounting against the donor
> most of the time. Without proxy-exec, there should be no
> difference as the rq->donor and rq->curr are the same.
> 
> So rework the logic to reference the rq->donor where appropriate.
> 
> Also add donor info to scx_dump_state()
> 
> Since CONFIG_SCHED_PROXY_EXEC currently depends on
> !CONFIG_SCHED_CLASS_EXT, this should have no effect
> (other then the extra donor output in scx_dump_state),
> but this is one step needed to eventually remove that
> constraint for proxy-exec.
> 
> Just wanted to send this out for early review prior to LPC.
> 
> Feedback or thoughts would be greatly appreciated!

Hi John,

I'm wondering if this will work well for BPF tasks because my understanding
is that some scheduler BPF programs also monitor runtime statistics. If they are unaware of proxy execution, how will it work?

I don't see any code in the patch that passes the donor information to the
BPF ops, for instance. I would really like the SCX folks to chime in before
we can move this patch forward. Thanks for marking it as an RFC.

We need to get a handle on how a scheduler BPF program will pass information
about the donor to the currently executing task. If we can make this happen
transparently, that's ideal. Otherwise, we may have to pass both the donor
task and the currently executing task to the BPF ops.

Thanks,

 - Joel


> 
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: sched-ext@lists.linux.dev
> Cc: kernel-team@android.com
> ---
>  kernel/sched/ext.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 05f5a49e9649a..446091cba4429 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -938,17 +938,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
>  
>  static void update_curr_scx(struct rq *rq)
>  {
> -	struct task_struct *curr = rq->curr;
> +	struct task_struct *donor = rq->donor;
>  	s64 delta_exec;
>  
>  	delta_exec = update_curr_common(rq);
>  	if (unlikely(delta_exec <= 0))
>  		return;
>  
> -	if (curr->scx.slice != SCX_SLICE_INF) {
> -		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
> -		if (!curr->scx.slice)
> -			touch_core_sched(rq, curr);
> +	if (donor->scx.slice != SCX_SLICE_INF) {
> +		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
> +		if (!donor->scx.slice)
> +			touch_core_sched(rq, donor);
>  	}
>  }
>  
> @@ -1090,14 +1090,14 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
>  		bool preempt = false;
>  
> -		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> -		    rq->curr->sched_class == &ext_sched_class) {
> -			rq->curr->scx.slice = 0;
> +		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
> +		    rq->donor->sched_class == &ext_sched_class) {
> +			rq->donor->scx.slice = 0;
>  			preempt = true;
>  		}
>  
>  		if (preempt || sched_class_above(&ext_sched_class,
> -						 rq->curr->sched_class))
> +						 rq->donor->sched_class))
>  			resched_curr(rq);
>  	} else {
>  		raw_spin_unlock(&dsq->lock);
> @@ -2001,7 +2001,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		}
>  
>  		/* if the destination CPU is idle, wake it up */
> -		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
> +		if (sched_class_above(p->sched_class, dst_rq->donor->sched_class))
>  			resched_curr(dst_rq);
>  	}
>  
> @@ -2424,7 +2424,7 @@ static struct task_struct *first_local_task(struct rq *rq)
>  static struct task_struct *
>  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
> -	struct task_struct *prev = rq->curr;
> +	struct task_struct *prev = rq->donor;
>  	bool keep_prev, kick_idle = false;
>  	struct task_struct *p;
>  
> @@ -3093,7 +3093,7 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> -	struct task_struct *p = rq->curr;
> +	struct task_struct *p = rq->donor;
>  
>  	if (scx_rq_bypassing(rq))
>  		return false;
> @@ -4587,6 +4587,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  		dump_line(&ns, "          curr=%s[%d] class=%ps",
>  			  rq->curr->comm, rq->curr->pid,
>  			  rq->curr->sched_class);
> +		dump_line(&ns, "          donor=%s[%d] class=%ps",
> +			  rq->donor->comm, rq->donor->pid,
> +			  rq->donor->sched_class);
>  		if (!cpumask_empty(rq->scx.cpus_to_kick))
>  			dump_line(&ns, "  cpus_to_kick   : %*pb",
>  				  cpumask_pr_args(rq->scx.cpus_to_kick));
> @@ -5426,7 +5429,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
>  	unsigned long flags;
>  
>  	raw_spin_rq_lock_irqsave(rq, flags);
> -	cur_class = rq->curr->sched_class;
> +	cur_class = rq->donor->sched_class;
>  
>  	/*
>  	 * During CPU hotplug, a CPU may depend on kicking itself to make
> @@ -5438,7 +5441,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
>  	    !sched_class_above(cur_class, &ext_sched_class)) {
>  		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
>  			if (cur_class == &ext_sched_class)
> -				rq->curr->scx.slice = 0;
> +				rq->donor->scx.slice = 0;
>  			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
>  		}
>  
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 
