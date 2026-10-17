Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3439F191
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268453; cv=fail; b=QvQxC7FhFf3BAi4pY35uMKKZmeW29x7Hfd3KA4JP3XRUN7BUxQxQnn5bfk6W1lFTdj3Gc3BkW7QRNj6n69VoI4SwsNVZzvIuPMyEgrROO9mytjdz84krQ7dU1JIUsyawxEs/vIgeY7/UmHBKcDFQ7mhq7jEhVAkx4oOx4Ha4ogk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268453; c=relaxed/simple;
	bh=C0RVnyJVcLk2mKhJ6mNLXjo8tYm35NS7wWHTRLMeYyo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TSjvaMy4ufKR44eEmStmGgvnw3vk8wYaCw7go/qUe+ReiDgVRArq+bgAkqB6jSsX1c6olfppAx2SjA+qhVH4qDRg4Xf5IFYG7UthR2297Hnll8YG+uCbixM8SjqkyEm0ZWyaS1yBdlAgqi1x9nurKEZ3lCEhgZovQfq3LYXe5Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKOccGM0; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKOccGM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7zv2kNIangFdqYgYN5kH38fy6oxRZg1RTgf/TTSZpBEK5IhP68IFIVzw2MdnLnnu7pOx/2+rWfuvVNVALGuwvhky5oJRnSh94/OWLLWGHJerB9bK2V+1+i+S9S84ixzPZ9oY+ffSUcrXwxFnL55YHcBaeZmFDJfSOZXzZCKrq/JuPZKIiGjO3lcdqWR0KJ3zyWGQwHEKqGRc063wbFF7PJN8QjrOfE2fIcGMmlMaRzslTrPhpu9VvzVWSIfY1BkWqR5E29BMPpHd7zf3aokBkxYuoB7BxkQJbXesddr3wxCGZPynzVQTm3ohCkKtKiovnk1XHYaIw0t1IWOoF1INg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqgStXg4N01eTuEIF+1JFXhpJ4Hv8vYFFVNTK63hFCE=;
 b=WaR0vL5+LNL3elyX9UYxqiX4dOwRiNk5bp/W0I9otfBMaX/lU3DDfPmJnAIQXoblIVEy6tgxeHcfItg0D5tnOVAs7AJXl2/BoO9u+mO7T0ZqluvCBDQkoXhw+mrCjKODGqAgm31KNWHQAjNL8MUpovLsh8caIugFFFOsqZiqeUdRhiEw98DoKzG6XBeKaFzKcyGq3SBpHgIENlYZjIs7pmIb9FBVpM/P6OZnMiVCkEwF1NTZnwRWgnDpj8fkgRMvZ669q5lm2MaruZjsNQBl20bx4HVBhpK7DNqzi384RIZc4cKc8djg2+kq3N9qgdbAMfw5qwRkdV6ve63K/FRF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqgStXg4N01eTuEIF+1JFXhpJ4Hv8vYFFVNTK63hFCE=;
 b=RKOccGM0ER+Stn5S/YHTB2ESDJ9RhLoL9ygb7jZuAg/wsE0rvGJm3Nt7u1I68nt00QPrRLQSRp+Sy0uhM38Z9KEH+dcii6omE+48N0H52sd4stNUJv7W6GSPLdp87WZW/mG7KMqXJSpBn5mRkXIp1tJb+wdH/sW3R5fDMekGqKCdXdk5Vj5IQVQZQ1W35PRd0196qgflsnWdSLnY+UeWE0TweQ8Fbg1PZSwe7FjLcMmndKaHN+/S8zoiZEK/CjSUnlgqu2uAt9qFiKg0/4EXncJsqyLeuxKoNrrMVPHcHcyXW63e5VGui4sO5HZGakTS2/PRAPjReBduBi+CvG4WHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 20:20:48 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 20:20:48 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix scx balance callbacks queued across a core-sched pick
Date: Sat, 17 Oct 2026 22:05:13 +0200
Message-ID: <20261017202025.3834954-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF00000AE3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4ad) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aecaa67-3d13-4f08-156a-08df2c8c21a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nAD0NR36EjcWbWWOkfep6w1gOIGXc+eyW4pxTvw9RqFFOr6oienZQ2gnmA8HpthkUMhFe/NArY1tW9YYVQOFHtvZ6ey/QzBSLPRqMAnz7BAJwIRFSozfZTYXsiftcI7yd/SRR3i+cvwj6tpheqmu2d6Mhz7UMldY6MJ4MzdAQevTW/y/ZfvR6GLsu24B1A87RtI9Ead1ua852HxlvXRKxtEWfQunE477Xy8uOTfn9Wg05jIZJEhY4RBOmvNWdZlzm5JR47ToTNqsuBbU00qnry8dw6QX7Ic+jRboX2uuHkuQhkAgYLbbMN2wm4h+lDw6GdV9/qWz0Jw1mVRyaChqQdtEfEb2MQHYC3BEXUYH+SYCP/YSr5jFa3xYFLSy1GqEVPAd14+X/xYWYoSUrs/SvoBi9AzCrq0hXf5x2e4f5CBCvspeHaFGoJuAY0gjadFpv489B8xJl+tt4nveWnrzh878HnhpWbWS2kMaPCrPeIQg8PuINHZvmc1plUNXXxVM2TcsGbwa2M/XCztFbGkCdEsDpbtN1JtBGfTdfCcv0Kyf+moLUU+G/qSSVvKOQLNZtARJ3+x651Da/qRPczuM07buPX5fw/YsvByAKg6CAfbEkt2L5Mq1H+lTSnWZj+5A9i+bNdzOdZb7Qt7+vyeyfwNK4jA8u5BAc+BBMeNFg3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bY6OwT/fXtApQCeEGbwkdZHQfX4BiVGZJthmadIJHNK/DktPTODrsLRljnc3?=
 =?us-ascii?Q?HMCy6hbF8s9tluBW+AM5GxG0KqenjJFrY4BIiw6YdxnBpl6czrzKSG0XQsv3?=
 =?us-ascii?Q?EWOH97e45QgWKJJrWb9/HKewUmix6afbbo9y91n5oO3NlaH8nhH2bfO85O4X?=
 =?us-ascii?Q?6sGuH91E2k5hpi6qfDxlLfR1I0lk1jnyi7+i3gw2vWP+tLoU7Wh2cqGdPBbx?=
 =?us-ascii?Q?GChkJ5voDJM+mafPkg0ZWGaJIL+uAd4E+1/b7NqSfQEeMGYmgLCJ4oBdNOuO?=
 =?us-ascii?Q?dTpku38GCcE63Xs1QqdmmLNVDwBezXnvBhP7Q6aL4DMwT18Az3AAvSko6n+H?=
 =?us-ascii?Q?kXysU0oBI5dKk4Ch+nRtt1LGBrIX8eQ2DaYymhym4NdVfzQk+uLRw+n2uUqG?=
 =?us-ascii?Q?xlRRMyi4H+KneeaUPGAiVfdduj4xo/Izk7SkHVTHsbyZ0taklO5Qys918Xkx?=
 =?us-ascii?Q?pNJfqJxpuSV/oHzspKPrubxlFXmXc6lYiiUy4v1SLvGtzXtDxc7rmfSexRQh?=
 =?us-ascii?Q?1boChm6t/BDA8Xhm3kX3rrwHc6zP149rm0TOt4IB7Pyz9KzCV37cum+bFika?=
 =?us-ascii?Q?rWcGCCdEXnZo2fCbXzaMGFq44XLxJX8qja8MjMWbCnNgmSKt8DRnXOyRtNMm?=
 =?us-ascii?Q?FwsIQuemm5ICRdEGfGo17cTpXHm6FfWO9gWuGoj0knkyBuWwbxp+757zYR8g?=
 =?us-ascii?Q?gR5c6Qs2oGc++VSqJ+v0yK6bZCNFtidPfci5sP4zTUpn86Zwapgx5x0ZPqQy?=
 =?us-ascii?Q?zk3V3w4wB8FI1Fsk1ps8sOA6blfG2wjhxJ+1dz5HFHWtiuSZQ24TAsMJPEVj?=
 =?us-ascii?Q?X13ZB/bLqX8JiRjdv/O3dAP2uKrxfzKfdbG6Kd9Ddm8ErvOxJOboWtYb3NZ7?=
 =?us-ascii?Q?W3+qCmlxS7KLrSJTsGS/c0qVcYQyJ/9f4oKpLPMutx9aLaH92uyvouhwSu9i?=
 =?us-ascii?Q?K7tSXRBGlruyXGChhYP8AF3FWiAveHyADZpo2U5R7F57geej+D4mbgkU+muk?=
 =?us-ascii?Q?Jlqiqt32Nes44KPGLk+2YR7XIOjzfVAxBxD+REXJ0x8qlAorP1TIdZORqWdL?=
 =?us-ascii?Q?qYQpeBl/hvAo4u1HKzaiQBj3hyami2h/GTsUBJdeLLSFT0ENeKt1FvTZa+rl?=
 =?us-ascii?Q?VqEM10pXhCZUK4hQd6a4akOyJ4R9+G6RyC+5s9XY0VJgDlX59BJikD2frRdQ?=
 =?us-ascii?Q?CBuH6PQ2ex16EHcgx8/nS/lPMUHSq+uWxmrGQXGXs7zGg8UJ6TK+68aI4OBM?=
 =?us-ascii?Q?x9i/MR4tMx8HS723ha490AkOCR8jlckUptLufRJcXKUgION3ODmBq6KSbX7U?=
 =?us-ascii?Q?lVGKTKiM2h786lLQwOHltcKERjgvvZUqckzSAMz5UPgG1HshHyTEADsL/wQ5?=
 =?us-ascii?Q?Gxrqo2iGD4qpHH1wOx8LrZWBL/i+YflCpxYqpmTAgj562p31pukKtTi4c/7+?=
 =?us-ascii?Q?FRYOXkTtI+28eyUar1SqL5iYVdYiC6AKg+vb6Pp0WTNw15ee+kZsGmFcFk0C?=
 =?us-ascii?Q?Q90ju8SkZBEeetlx68gezOTw47s/o4HrLn5DJE4Xiwr4y33422Gu/3JOeCbM?=
 =?us-ascii?Q?3EGb3/dKWpq0PU6JBs9QF8F84OCrvZ3XQTX190vuyd5jC8qHEcAF1CmFrSc6?=
 =?us-ascii?Q?ugJuji6/5mNSDcLWU9niU5JoZlO81j23CIIzpWuVKntamd5f9L4R65EUqduh?=
 =?us-ascii?Q?T21xoiS1wOB7e0nwreWAB3a9ya2Ac6KtjnVHDNcVRymDAg6K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aecaa67-3d13-4f08-156a-08df2c8c21a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 20:20:48.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FGNQvjio8BiXGn83Kon+NZ0PghBAQLIvEv4dRFrQkpdGa0OGQQCTTSQ9bUaS+N2XXUnTyfgJpZGLFd2UY5E6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

Commit ff0545e0c263 ("sched_ext: Don't leave balance callbacks queued across a
pick retry") queues the scx balance callbacks only when the pick is final.
However, under core scheduling, a pick that returns a task isn't final:
pick_next_task() goes on to pick the SMT siblings, and their dispatch can
release the shared rq lock with the callbacks still queued. Any CPU acquiring
the rq lock in that window triggers the warning in rq_pin_lock().

This was pointed out by Tejun and sashiko in the review of ff0545e0c263 [1][2]
and these are the follow-up fixes.

Patch 1/2 always defers the pending work to irq_work under core scheduling, for
both the local and the sibling picks, and leaves SCX_RQ_BAL_CB_PENDING to the
dispatch in flight that set it.

Patch 2/2 handles the kick_sync wait, which can't be moved to irq_work, by
taking it off the local rq around each dispatch of a core-wide selection and
queueing it again if the rq lock isn't released.

Testing:

 - The core scheduling case (1/2) was reproduced in a 16-CPU VM with SMT (8
   cores, 2 threads each), running scx_qmap -I with two stress-ng sleeper groups
   tagged with different cookies (coresched new -- ...), one of them SCHED_FIFO,
   plus an untagged CPU-bound workload. The warning itself is racy, so a debug
   check in scx_rq_lock_drop() (not part of this series) also reported any scx
   balance callback still queued on the core when the rq lock is released. With
   only ff0545e0c263 applied, the check fired in 5 of 10 runs (always
   deferred_bal_cb, both for sibling and local re-picks) and the warning showed
   up as well; with 1/2 applied, 0 of 16 runs.

 - The kick_sync case (2/2) was reproduced with the same setup and a temporary
   change to scx_qmap that kicks a CPU on another core with SCX_KICK_WAIT on
   every user task enqueue. With 1/2 only, the debug check reported the
   kick_sync callback queued across an rq lock drop, both by a sibling's
   dispatch and by a local re-pick, in 5 of 6 runs, and the rq_pin_lock()
   warning showed up in 2 of them; with 2/2 applied, 0 of 4 runs.

[1] https://lore.kernel.org/r/20261010095208.276806-1-arighi@nvidia.com
[2] https://lore.kernel.org/r/20261017152226.3690249-1-arighi@nvidia.com

Andrea Righi (2):
  sched_ext: Don't queue balance callbacks from a core-sched pick
  sched_ext: Don't leave the kick_sync wait queued across a core-sched pick

 kernel/sched/ext/ext.c | 78 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)
