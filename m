Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20732B127
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018023; cv=fail; b=OS1WDIqV78SXZZJm1CemfVDwjC6uMUgpi/dM958mbkHD6LXvb7CZTyxjuD3PUGcE847dWAAZ6zmsBbs6j8fk4UG6lgQvC6i/2pPtSTDsCLp+UJLReb+krzmFrVioWvEMWk3KXOKVHb5ipQg59SjxGqYjD69/Sm+p2cDhuNIHTAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018023; c=relaxed/simple;
	bh=bWHHBF5KqgcMXdl6QAEsMYq+iCp4u49OmbPWRTzEUtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4LmVG5B9RzJvnLrWatHBOYv8MrYmnDQYNOF+AHwUBxh5yM9XrEK3N7HsAqUcEQyal//8oglRjQtFJkHuAFoFRWGlHiAyrW2ti+JaLvV1BDf1DPkDT6ahHKA2DBVZyd1xoxHve7SNI5YqhVrReQt2svWjMS6MTj8ehNmlD3RGMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dxpxT3P7; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dxpxT3P7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/ctxBiFZr1tPLNMawbi5ARXU5E+vDozM/1lhqDU/Ggi2A05wH1dki7Pov9SsVw4tBOXYF1uipBVsmjBuCZ8tQ2SW9Cers1aYkr8fb544mpslKJWS8N1bRA9gCKse29eWD1H5kmPbCqQrX+c8yMWe5d+QLAWTL7oHR/6qdhByOijWZzB/kh8I02x/mQbcDJDthhK8tjYrJaarY3t5325yPculjxjyfsjq9nDt9HgB8cB2AzC6PyGhXgR0tcBU0ah5s6ZtJDJY71mweD4Yt2e27zRD/hSfuhso7+9WkEWiD7ePFFYr8OgNUGF16sKLjQ7D37b46NbcoWVic922qZS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odWidGsUg4yFIZI9ePLdINd2NQoulqPmWnfyKYD+Ey4=;
 b=oYcXRR4d0qcFJXheVFSi/kpGEhVES6stUFB9a0q3fYmLD9uMaI3dBADMIWrFROPPChe8A9REVQ3wkazA4h8HIeCkrTo7ivnwnPOZef84APJ7X/5/J3h69M74Hv+ePY37Nwv8YpnqMsPxML/ARlfRRWpni7yOvorJz2iazoseH4idZcB9V8mdGtwsljodo/cwDMJRvIQ3k/jJBnK7O+RbVY5PgOc+OYg8p7wa3jb82NfVkchkAjvupKpeMqwD4DB7yvsfaEV0IuvUqJl+akeIqYK+4Unem5aZtwCVPcALwrUOsKLhn2UuEJfuLc6+WyqF42+jR+AVExhVj3PUryGykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odWidGsUg4yFIZI9ePLdINd2NQoulqPmWnfyKYD+Ey4=;
 b=dxpxT3P7SwfykYeqABSpcz8Kdq/w8eoTaMcF8Bck75qaa5LwdLkQRUP4IArf8VewLzJlaxq9dl3BwKBXOj7a2AHbyrEWTMb+mrnZYQQzWcjWwYqsv6tZr+77AAmxKY9wQ0rgQR1E1Xl+xgZCDSriSZhiYI7VUf3rv5L3vVDi1xYLb+vjlIFH+vAFV75mQuRLsUmbOyzM6sL0+UacW2aR5R+YG1ODpsBK4tWIBaFwpRMfmBWcI39ixMb3Cu9grlI6QGY8CSw6aYxTAYVuZHH9O59FZ+xeoLyMfBazFW8apxJyw5veO7IAt+aB5MvyvwYxD80REvDVFZUnR/c1jDadkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 18:46:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 18:46:54 +0000
Date: Thu, 2 Jul 2026 20:46:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] sched/core: Skip put_prev_task/set_next_task
 re-entry for sched_ext donors
Message-ID: <akayFICg6GffF2FD@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-3-arighi@nvidia.com>
 <20260702182406.GM751831@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702182406.GM751831@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d4e4fe-5523-4758-1381-08ded86a4990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+FkCS14IydjhWudaqLGtAHf9L29iKAwnCbQryxq5CCBnA5Dcq5a6WpniHx3uU1thCT/2r+OfzC5c6xh6YiqikK10vKk931wxpxRQQqNbcuytGuI0ECKoIK6w+cyNc87gARYt7S+zjfyOgHTA90BQHJLaTPHBXdN2wwsoLYf7OGkQHA9CwpoqID9seS30nyJOEKEliVhHwjXDKFCEk5fCE3MWiKyCzHXuYW8ATVPLLR6vsBUHK1ZYcyvvMdtX+IaoXomCEYoC26HlQt0z7U7sls8u/pnVfwtQ76RDxpjV8y+7Mve0wb+3aUT6NrvBRZzKj7hhgMjvrIB3t1SYGojMGNhR9KWt/57H5vdrMB1Tfq6K7RoXAPda/TXdh9PUsNt+GctLjtzi0ra2Xq3wl4EAfWcqTFz/aiDswi8YqW0dLJ6Fg7ScIybT2W1kgT8v2d24rXwvFkYd9JTkKkE3V3HBOJGkXouMMGQ1k2zR49Bdz8SDocpdMFkFCknh8sNHmT+QaKeE4uiPvJNNVAJQQAhw8ra6zxqXh4a6dalDUf63TksK7B7w4y4GfIgHXNBaF22UAc6UdVvEHCKrapBGV5KAAsWxZlSKGK4XFGa4FRx+juL7wQyhU4hgTiILVCuYtGIzZPlOiIk0n7CRfcWRGFk0OUOoVciJWcHR3Rdwmqz7V4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pNooxK0EA2eea8P99iWivHRqFan4FSkE7WrLdBiJpSPclUFwA0yTZxzOh5qq?=
 =?us-ascii?Q?ikB1bxGbGOUJSe/II/fRXTcfKNro/g2+dSTnM3xo3rmg9w1SPod8i6HIQrpa?=
 =?us-ascii?Q?WE3qAkVSKpZVY/WnujtK+sqK5cv7gniWKVKdSLabX2ZrsKIj02FovrdAEjAn?=
 =?us-ascii?Q?9Yjy7YTI1yMq1RC8tyDhg1u9lEHj06WJEnY2ff4+KMZjD6nl6BLtQOSOK5II?=
 =?us-ascii?Q?8oU/6LP/SttYsm+jwL8lkpaZZabtrj23qUETJXjciQWYFrifGuZAXm3xl9Gh?=
 =?us-ascii?Q?HiLjrrLRppYGKi5UK1LZ7YbNywqgH82p2/sTRgKYEo20q6tOc1gZlWGcgIdZ?=
 =?us-ascii?Q?eMjOQfLpzFk5Wwlqbc9THyD1+QUosYbAeIjD3ViTmz12MXzL1gtdIS9lw11l?=
 =?us-ascii?Q?0cOzhCZSjVt0pH4XASH11H30xOxlVlzeuO9eREmXzKMvMBIP46Z21XEgSY1h?=
 =?us-ascii?Q?yfKhxQD0rbfuodyYIHaD8jm3Mp21t65ThEhm0HPgBk9SNduYru1ONrf80ARa?=
 =?us-ascii?Q?vrblANmJMqmcdsl0UUnWmgmOBVR8oomxbAk+4m443DbAKBvyBqoXhqgmXD4T?=
 =?us-ascii?Q?GqUVPe72awls6mg1MGuAgDiVJaQHpgVWPNNeOtqFPq9GIo8i13niWlGRuIJs?=
 =?us-ascii?Q?ZJRX2l9jcNsHyAcVdSsGEBxUSIElcfsyqv1jtLS1tS/wGdz/paP28Msst2x1?=
 =?us-ascii?Q?yeV2NfHOadUdeTlpLMZH6qeZ8gBkQV3fFYgBeMAHdAetv+jNucyf1E4E3I0r?=
 =?us-ascii?Q?VWDO8M1qJVU14vxk/ybvGGp7pMzTLqLEE8CYX5GONP4dQ+bs+1zTepb7fD8+?=
 =?us-ascii?Q?71SQToT2bjH7tMTnvwbBS5Fimciv27DqIHTZYmcB1J/SGGZJ7LupXPHYJzQa?=
 =?us-ascii?Q?0DCORVcmoeIKu/nuBSO71vj0oNkk9S8QdKTRB8m5Iuh2YIsBQWuTN4ckPfMw?=
 =?us-ascii?Q?IJg7ODoQzyN7UmhVECh/U9Mp7opS8ey2SIHTYz5oKA4TWlEwmquztYDdNB8g?=
 =?us-ascii?Q?5c1K5IuN+JXhHzHqoV4JoIwWWnUM8bKCm8v0SRMBw8eOpU4BLm0STfR7NIiX?=
 =?us-ascii?Q?blskD8Bw4OrL5wvnvn7HDrRcNuBl+qybUYE0DGxVROuTtKNJNuxqYf3gu4GV?=
 =?us-ascii?Q?5V1PAZu402bUY+DSM3IkNm4GGLLjGnZ695+ySKy2vGA0GXTX4hYsC/wX45B7?=
 =?us-ascii?Q?vnCkiYyIrsboIYmrtSrUxd0HduPYwPWTrSbHXlx9SpoAPd3VX3X2sgTT1W5m?=
 =?us-ascii?Q?SNmOhR6Zp5Otq7rNIIHEKBM+pGFw3GQGNM0+8s7zsrZdcl3R1QwofAi0nPkO?=
 =?us-ascii?Q?PYPl4i9U83R7LZWDfG4pVFMFfAUYzWlEvYn9RU4+7ZiQ2bON9x7x01A0ZHnY?=
 =?us-ascii?Q?ix5g/SMxggWKxzjc0E7uHWr5HZ/OH0jNFLJLOjpsk+OOnLdJqTYhFbk+dTK0?=
 =?us-ascii?Q?vUW7AZlF9ihLNo1BN6WEAXGp45aRbeBvDgpcC3LlZGOJgxlrILP92br2MWFW?=
 =?us-ascii?Q?gI7VWNoZ65YCu9ixfo29Sipv8DbSGHXx4TxnHA+GeAiKNfBpJ+WaSv8rSEUw?=
 =?us-ascii?Q?DASy/A4xx2pVF0+dypBdhMh8+I5KQ09onjU5XvSNQ9Z0e2IkUouCY/xWEnNX?=
 =?us-ascii?Q?bV5Z2rD7m+ci9AKbKiRb5cR4FaYfuqjTrn1i0oZOAUAGFdp3hXQrq+ku3rHC?=
 =?us-ascii?Q?vaUnJQfkh20jKF4QdOURIr6GPDJSdx4ciAENjrRUo8MNHo25b02+hrxn/veh?=
 =?us-ascii?Q?KjwpKW4ifA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d4e4fe-5523-4758-1381-08ded86a4990
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:46:54.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgR+eWh4vE+9bq2gnsRt6sTC+9TuKqf16yCUzm1KzlzvyztwqNikHyGmIK4h8jMbxOVOEcPWef54dTfgyR4DoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

On Thu, Jul 02, 2026 at 08:24:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2026 at 07:09:18PM +0200, Andrea Righi wrote:
> > In __schedule(), the proxy-exec donor-stabilization block calls
> > put_prev_task() and set_next_task() when rq->donor == prev_donor and
> > prev != next.
> > 
> > For sched_ext tasks, re-entering set_next_task_scx() for a donor that
> > has already been seen by BPF ops.running via the normal pick path causes
> > issues. It fires SCX_CALL_OP_TASK(sch, running, rq, donor) a second
> > time, and sch->ops dispatch can land on a vtable slot in a state that
> > yields a NULL function pointer or corrupts the stack.
> > 
> > Fix this by skipping the put_prev_task/set_next_task re-entry when the
> > donor is in the ext_sched_class, since sched_ext tracks curr/donor
> > itself.
> 
> This really sounds like a bug in ext; how is this different from the
> sched_change pattern doing a put/set cycle?

I think you're right, the patch differs from sched_change because it doesn't
bracket the put/set cycle with a dequeue/enqueue, but sched_ext still needs to
support the put/set contract.

The underlying problem is that set_next_task_scx() triggers ops.running() for a
blocked proxy donor even though the donor never becomes the execution context,
so we need to prevent triggering ops.running() in this case. But this should be
handled in sched_ext by pairing ops.running()/ops.stopping() only when the donor
actually runs. This is addressed later in the series with explicit running-state
tracking. I'll drop this core special case and rework that sched_ext fix.

Thanks,
-Andrea
