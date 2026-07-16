Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CC442FDB
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224089; cv=fail; b=Wi004gp+7d8vkFj+9ipRHB0CxxjUTpf3EzQI+XrJeEnfjr+IGuPAr6Pex9oEITFZejDi1efJgASn0sWphMzwxypbK5QhTkJOLzYzCY1yJZXbn2OLf0Vsnu01qUKMNWzr2F0qJXDUmFQgsu3pF/UoAlubkrkXtO5Agx0etYmLhxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224089; c=relaxed/simple;
	bh=+h/anWiB2F2Qd3KcPuCry+cK9o+3GaB6hHYUuzgHUjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iDo9D76i2O9UhrWb8WZP4tfpt7JIUAeqQSFD3fN90DUvKMKH4rAKDE0t5J3kc2nO/A+xDbkl04NavJOsx5lvOqfuNnuENVITVNzt9BTSw8WEfBSjSddRvHw7HLc4ili+545+GZ/0JKJ4s68VOyUdkBPfCtEUEukW9rnfek+x8p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1QsH4q36; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1QsH4q36"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofyciiWb72YKR4+8+L6cHsSIwAWlHdvXRHY47EGrcuAA3nAog7yaZUDC0pcppWnlArmI+fb/UZqrTGTPJKkk+gv8YRDfx6aMpI9HefRYVqLLgoThDuBUzlOT/OTPUYwJmZC2RVlsclHvh3uIE2OFIDiubaozug0lHdIck0jPiQI9xrm6iQzbo7kwZISNnIBSp/7bRULwi9IbeIq9ERhif3KkA5tFtxC3cRFMbaSoUN6Zgt1ncpiDVVYWj1oPFkrydfMkTYlnH1sn6vf2tP3mqOpHxsmq7lYv+RN9tzq3ZkEAqV/I0BM2ZsNChiAzZ9vuj+UZN1zdqBNU7uWG/IqOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO+iFDmu9YbwGMg5oWbnxRwRuYLmBaziESpA2/r+RZA=;
 b=n6psfjU/p6/5XUZQzhV5ZRo7Yca74CGhioT4HQeHAQYYbEr0hnT8L8yiYokAQ7fEc+gvSF/QTdFC4YdRWN2TEzN4648EtOiNF9dpT/Ajsu+Fl9Qv+B6WCbJr+lzAMsNW5CTY784LHJ6qL2rVf8QP8pOrBBuqtS950BBWV3fPa7qkKuZFdt6vd68hAtgvoccbjx3TmxlM08bIAuwbWcLxyzt61no/mtb5WW/S462ohVccaRETGWQcInSlg1qmC2s9NcNwM7T/i59j6Uf1IczOQyK/bhIJe16hDfnpFi09mJY7tmPdpgWv7/Yp2bG8Wqajip/PZL1LB+sDm2CTWJ/buA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO+iFDmu9YbwGMg5oWbnxRwRuYLmBaziESpA2/r+RZA=;
 b=1QsH4q36qSnNqcLmjE0zB557KnC0p5UQwlLxexrfWtdWQJy5JHKlE5Wdwz6V6K9tIQnr7NXJ30tOgds2Zdgh4GKhieO+Ds3vFXHjCX7lYnzcwMmLEYbmbGZ6rnRXSgkq9cSi6pyg04QuoCKTC8/lhL7dNaxBEcARnFcUj6uv5C4=
Received: from DS1PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:23e::12)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 17:48:01 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:23e:cafe::2c) by DS1PR06CA0025.outlook.office365.com
 (2603:10b6:8:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 17:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 17:48:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:47:59 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 12:47:54 -0500
Message-ID: <e6dabae1-05e5-4e42-86a1-fbf8fe71b801@amd.com>
Date: Thu, 16 Jul 2026 23:17:53 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] sched: Add helper to block retained proxy donors
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, John Stultz
	<jstultz@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian
 Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, Koba Ko
	<kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan
	<shuah@kernel.org>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-3-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260715205622.276220-3-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d1843b-d9f8-4ad3-9059-08dee36260fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|10067099003|22082099003|6133799003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3rTnWEvOapOB+crSzqlU5Z/oIhUj+NBaTX+Q5sK+rldL2bKFhtNwrSXV4K7mOvOmabLCTVtVnjVMmTe7ulIp12M1LB4a8QykDTZqsrE/mpHwbyT6mXQMiXLdnCxOHEOJbN6S4QS7v/BrEydTgQ4pkBp6CQTUWh2TVL4TGvoPHGE8+TsnMqA0t2aS+qtrB8qR7eyaKONN+sXWXf9ygdfsno9TJ2InEUNTbxcqR2e2pZRX5SKjHD1lOYHScrrXqeTDLdfYlLl431VGiKE4zzVZWLw8kyHHgsPC4Zn1KMyVTtO6kGpOWm6iUGx5Wnq4kKHYT/rmcJ7fur04FBl5Y4Kz+73hJIYq35kIiLxxU4n3ddyjGk/5qrWCWinwCZ6ZAFydx/W4l/DvCwilNSkXq2WSd3H8ofKHMRIBgg667RDlTQQrCTFyw1n3DH+aXbD+RA38Qbvs2AwsVulUYa+GdZ1FP21C1dwMz9Zp7XmfN154AF9G+N+DVDxa2qKADF2bEeF6/xTul3LhV7taJ+tFaislKwwL3r7mowaHEVDVC+S35ow4U/61xNus76MVGOBZILAt8NYJ252OR1GsuFNL5FNyBV7Sg3XcWJVND+OpStqs5LxV+WYIwoWzleLsLqzdK1xNBbPwANQQ6VAcAGtYj3bBLoAnhl15k/q4o/Ed6cFug42EKw2GT4ELt574EPCxc3x3EK8OHOVzcFXvUJM5bjlvyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(10067099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9eLwARrdHo/701SRIieYAX7kHQFVJ3hgSWzZh7Uf/C7rb7IvMRF1TGBpxChfGxH8mh9QQsEmVPsWSOJe93ZXqh/+n+gFIJ4FxMJ2o29/CK+7wzAqct3k2iWlpdgs3mR1GSH5OTchmBLsTLBHgqOSAFGDoTn0n0iFy3PK5tyydkp4Ut4cpyKLejGZvifM7raSgejRqSrMSdGxL+Y5NljYhp59tbvOMZklvIApGp8lvumerahJiIu5ZglWyMRIrldkcMHVMuSDFgQ6d+lbPTDPgsabKNaUWlWkNZxmPdVHQ/YTSRAWRdgAts2NXc/VdotVgmiRqaqOdU3YscktfjOTwqN7g8J8VRaf+98wcfOJhymBCfu5gqrXJPPFDsjA5ntLT6XjendyNLjQNyarySwNXwdU0f+c7YGlJPeqZ17/J+Sm4B1f2yOmLlFivnJSIBvz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 17:48:00.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d1843b-d9f8-4ad3-9059-08dee36260fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

Hello Andrea,

On 7/16/2026 2:24 AM, Andrea Righi wrote:
> +/*
> + * Remove a retained proxy donor before changing its scheduler ownership.
> + * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
> + * drops it from the runqueue.
> + *
> + * Unlike the regular schedule() path, this must leave @p fully dequeued.
> + * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
> + * which would let the following sched_change preserve and re-enqueue it under
> + * the new scheduler. Complete an existing or newly-created delayed dequeue
> + * before returning.
> + */
> +void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
> +{
> +	unsigned long state = READ_ONCE(p->__state);
> +
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!p->is_blocked || !task_on_rq_queued(p))
> +		return;
> +	if (WARN_ON_ONCE(state == TASK_RUNNING))
> +		return;
> +
> +	if (task_current_donor(rq, p)) {
> +		proxy_resched_idle(rq);

This should be proxy_reset_donor() else the current may try to
do a sched_yield() with idle as donor and you'll try calling
idle class' yield which will crash.

> +		/* Kick the execution context if @rq is remote. */
> +		resched_curr(rq);
> +	}
> +
> +	if (!p->se.sched_delayed)
> +		block_task(rq, p, state);
> +	if (p->se.sched_delayed)
> +		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
> +			     DEQUEUE_NOCLOCK);

nit.

This case gets dealt by the sched_change_begin() which happens right
after scx_prepare_setscheduler(). Do we really need it here?

> +
> +	WARN_ON_ONCE(task_on_rq_queued(p));
> +	WARN_ON_ONCE(p->se.sched_delayed);

Very defensive :-) I personally think on_rq check should be
sufficient. Delayed but not on_rq would scream at wakeup.

> +}
> +
>  static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
>  	__releases(__rq_lockp(rq))
>  {

Also kudos with the sched_ext + proxy demo. Very impressive to see
that latency reduction.

-- 
Thanks and Regards,
Prateek

