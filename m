Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE8274B28
	for <sched-ext@lists.linux.dev>; Sun,  7 Dec 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765115657; cv=fail; b=eRMMsmqFASFZtqGOoJGPuxurXLd6Sr6dOxbK+OfZ5LNadO6AmVNVhgHqg4iye3TbBwqt7IN3H8VxvOiR31HpJJ7kikiHzH2QkKPb0gqHT3XyhyFtguly/cJNgrKidGPNuuS4GzsUxOyIHcYL/m+e/Ie71LsSo0MLacJ8T3sjGKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765115657; c=relaxed/simple;
	bh=fuVSn09Um9anN8/SKigvvzgRpiHmSrP3HonfbvpzVck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUaEOSULm+lQZgMlCiAPz/nJL+9c1ugz0Vvy2tKmQUIil9Y19seH/7oL3d9SnRi65fmcAqOMqkRJEIrJ0zTwtXNA5QG5gAxRVVgNaM84wi0D48Xp6tAnzxZF4mdGknP1JN/EkpxAPdut5KyfouHdu+FHoe/mj8pEuCxYKcd5Wio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCEoovDw; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCEoovDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8aU69e85m1VXZRXJkIvPzQrg/yPuWlsIFejBmvBS3XFHbWID2p9aGicJEXakBBb7cJEjWKkCTMYIjnnnt/P1tZh/oNRRNxKCYUuXib9Z2SIJa8E51k1nVmYs++t/N+usLPnK2RPAYwEJN9485OTD0zUz6WRbE4XJjp638EMYbPOxBenu9VAnAWqilc7zVdzmauYsEBb9FOenhTwgiIeJXBxBwOyiRupDjc9X1BTYoKZXqHIQWnOi4lhZL2HpaQ4UjwEnS+MdmOHhF9OP3sLYUFcPFdrG/kjNIFVrQP1GXT63sUxbKPkOeDufm7e3IQrN/BfY+dwSHKMf4dNn+kjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NzO6XYL1yfetiYYWEdAPnqtOY/4JCnrnXHcbFntBZQ=;
 b=crBI/Mp7iL8Sb+fW/9KfRpfDKefmA0r4i2GbfZ5YfpHS6rZ5hyRd2cCkAUkbydDEg62vSF86RX4ibtSEZDOzkK9TWrgby3sLw3u1R1PvgSkPiDm/lOjcVYx7GSZGoyPxUE45uJ/o4tvA3G2xohkmIILEXE7f9HyM+yltjbg/Ego7WOUumFfN7mKVX/9cpYgBdMgQ2XNC8xbV6iqlKD9hBKSFLEsGJb99u/Zv4rIrAFGmZV1m8cHkBvt/t1h+gc4yMHVUH9IG4Iepr0JnqiFrIl/iKFDkFXjk3b0j5j6jON7EKoMiX+s6quikdmGaGPYxUwV2hnJpvoGI9PZ8grLLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NzO6XYL1yfetiYYWEdAPnqtOY/4JCnrnXHcbFntBZQ=;
 b=lCEoovDwr6vbpqRbW9zkrR4sOLYBkJmBLTmq2/r8vHexwgX34Hixo2M0OnlUzfSHg6AnEtEvk408puCF7PkF15IoD1iSYUar8VKc1SVDL4yXbyeVzkMlu2OJAGhRCCL2hrzLKoh2dZmY4jGnrOMJ0AT+Kz5IilR1XS/s48nBTdQtQhzRAZQ5PffzyNExE+DIkJRQ/l9c5tX3OK/HA9MhmbUZu1U+BIFKfhKgvWvFqHOhyI4ZY0v+Z5RAdSVpoWYN8GdOjFhzFnBXlfH22sVfl2IGaN4Z3vrG3PkMnQE17c5sDZtuYAnFLxMuoVKgzmdQFojDGP1F8iRMybhL+UmSfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 13:54:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9388.013; Sun, 7 Dec 2025
 13:54:09 +0000
Date: Sun, 7 Dec 2025 14:54:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
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
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
Message-ID: <aTWG_BO7xv1U1d0l@gpd4>
References: <20251206022218.1541878-1-jstultz@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206022218.1541878-1-jstultz@google.com>
X-ClientProxiedBy: ZR0P278CA0114.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: c1168e26-ec83-4bd8-4ac9-08de359817d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iuQfgNcCkZg4Em4Y6DF/fh3lSRZUYtXgerFwHOK8e5yYml95msDnjWazwkAm?=
 =?us-ascii?Q?lBsIukkh7ATqPvvX7p3zC9TkmpCIisqnCQipgckDVgQbrUstRHwrUd7bNxfQ?=
 =?us-ascii?Q?C6zGwhSozmhSofrJcp8mkveEMqfS7gGvBJrktflde8OcbWt50TMRwkfcBvBW?=
 =?us-ascii?Q?K+olrKwdrQshmTa7MX/ApQtyw2UHV+Y9HMl9dXkPYbpU9plAK27RO0dK3z7q?=
 =?us-ascii?Q?WiJi8kpjXOEnMJa4dnFSl1WqJ+pXOY5ijYgJdDZF+2O5CYTbD+euRXx5zLx/?=
 =?us-ascii?Q?twpigbXG39+ObYd3QhwdyR4vuS7lN1hBNSrDuabpjo33cvS4+77HEO2DMYcc?=
 =?us-ascii?Q?LDgdFBsxEfY+wzGkM6eKt8u7GBtI1WvkIbnL/kn0ZpfpWff1X/YktL00Y7q7?=
 =?us-ascii?Q?omsYk4qqSSj4wMAZKjx354ziIsmX8uxgVoCJtI+ZZ/cYAzrl/zSb0IN+8feK?=
 =?us-ascii?Q?GG5jkAjIXZbEuoQnGJO26cDYiC3cHgVS8xiTvnnabycJQ7xSCdc4zlljMtLa?=
 =?us-ascii?Q?7ZsTLEVtrF677121Dvkm+Suncxt7FPYKuP0EG6r69U+4NNMAmEcQC4RJHD9a?=
 =?us-ascii?Q?k5tAsmvEdLa649QpEgbtMbbnBhjX4sAnm6lcdTClQBe8gQkN727bbHEsntBt?=
 =?us-ascii?Q?HQMnJpxOJK7gkCeMrMFIfC/PxciLLHRRBGcE3xfbHP5Vm3JVobWoQMxmwSZC?=
 =?us-ascii?Q?plBl4Rr4iRmk4CoyAO9746ZHiorvWDjmVTU+/EWUW/Dyi7jicbB82P5lnFOv?=
 =?us-ascii?Q?0PeVYURFNjcZNhRnnR5qgcqATmVL3vp4l3oGtusNoctNF0bco82YVtXcKyDr?=
 =?us-ascii?Q?kdx+N+W61NYLbbVxgBX1hlCj6j8aE3UR9IN/wit2x2+mRLT9kMX8sa3lG0J5?=
 =?us-ascii?Q?KR4jErwdpGkzyUALUXwwcaGBvs/pMbGVmXwmoSMlpr6WJ4fPkHLDfaRY4ahg?=
 =?us-ascii?Q?dK7XcVJkFYWCskCMNiQAeBw/qJVG6Sbbcp7kmmvFTX+Lcv5pAwME24q6X2Uq?=
 =?us-ascii?Q?5WewWGoN5Equ2GgPUEqfvxdgzAat8OxFInL5qP8CxgjMTjfUI6gFYCNCHNe/?=
 =?us-ascii?Q?6eK9+ek6ZN4vlsrAXwfojaoGeZJcM15MsrxlPiYtONwHyCWoK7p/UY/9ZUgV?=
 =?us-ascii?Q?ng8fj2j7jnSroFz53k1+Vn/O+VnrvEgzaAQbVjXVZVHXOs84dhaj5LWjYI93?=
 =?us-ascii?Q?rrK39ePTZ8qESD9otGO+ZJ8YIJPowFkJdCQgqnk+nKaPmR6MLYyVFyIdLfxS?=
 =?us-ascii?Q?Ip5KpgKwQvGMQEf0RZ6SUHWxmNpOwLg6P4pGuJotKjBWXopTzX98ZofqzOT3?=
 =?us-ascii?Q?OTKfYrYjnxborfdy3YoHH/oRWKpjgWb+jBgQUXMyUJ1PFR5v3DDSxjicJHfK?=
 =?us-ascii?Q?AKlqO8y7r0myRSF12+c8psowd/A8qCQlPdjQUUpa/VUfrhijEEL1SkrheZBA?=
 =?us-ascii?Q?68fSwJOly1IC98pdHHE9NW/2Bj7qjKaY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0qCfIbmXQJbPJkfDE3ZJ/fDrONkZPOpWZv8+sMWIoZpmyGkSnRi3pf8cE84r?=
 =?us-ascii?Q?EV4peflsW4oEUcRynevdgas1xSuH5A8IoIvx7EFyIhh2+LlR1WeSUcJ75DTn?=
 =?us-ascii?Q?F29awh2QOJYFw2hAT5Ld8+JZ9s0H7qtbPvan0KyULnWOL2Al/julSratr72m?=
 =?us-ascii?Q?BdVeRhxX6fqLRo97ifrdtg+UaIFSACMYTOBSLo2E/5mbulu8SNZQUL5K/2X3?=
 =?us-ascii?Q?ZNxVeCVGG1qtmg5UIifNKYF4FVCRXe08nE8Tj9/412pPG1JrmLp4TABm7KVG?=
 =?us-ascii?Q?Dkb0LD2DSC3BhLYRCmW4qwTZHQFrhuMDc7PK6SDvtk/vFFTSjgmfM9zY3mNA?=
 =?us-ascii?Q?VbqpWq2ztiMetV0FvakmJZT5W1meWVX448AAJFoWYJodI+1j3krmOj4ZdCMq?=
 =?us-ascii?Q?NiA6ej9blWQRBDMFDhMd96JZ+gTr4j2OjzObz3gTyvVu7LbdA+r6BVffVacr?=
 =?us-ascii?Q?guG2oGNGXd8ErDMhKBCeoaEGFJu9CstiSUs9oX/hsXeVLesObrOBmEdZ3IQa?=
 =?us-ascii?Q?KK3Q2orUc3aLdO1DIjiwGL5QcoKOkwyDP6Iq+rnU403Cq9W8190O5JBgC/E4?=
 =?us-ascii?Q?fSNRI72PY8OnWX3Xao49wus5mNEfPb+U8NiHDCmv+2bHZ1201aZQccb/J2F3?=
 =?us-ascii?Q?fX634sVhoPAEQ69A2plDBM/BSk3oflOj6qCSRfZ79paOzhLM9+AgklNQP08/?=
 =?us-ascii?Q?PkbDULGKesROsVmu7JlvxosPopeCt6ZUEx+R7yhQU50pRa3JlPQQyn1OTzqQ?=
 =?us-ascii?Q?fCVNXSDorRFdXlOQMfVsWQgxttGSwazIC/cZvPlUkTOSyChAvvhw4QQsbOE3?=
 =?us-ascii?Q?jXwDFWN1dy8LUfKVYc5MbGp9fbqGORZlk+Yi4+GIeRXI/kTRbNthNycjjejl?=
 =?us-ascii?Q?8OIz5XHOIrdcOxCtNoDELPbloQ/6NuCkcLqMcYGG51zWr9LSejrOyydoATJp?=
 =?us-ascii?Q?d+mofrpe/7ly6cTXdzjIPkNcHEomZO76bRq/o98T1gHiOdrAY7NuHqA67skx?=
 =?us-ascii?Q?7h4MwxTJoWrv3K3iRcMSBjx4PujW273BPZMkUF3V+Jg6Jz+bFiPB+8AV8tRC?=
 =?us-ascii?Q?Ybe26SNfKbfv4O3abrPWiXGPaI9AoVomXt556SAmSDanwIhjA+2tHOnHhnK+?=
 =?us-ascii?Q?vsOrNW4aK53jP4mLG2x0Cv3kf9uU0sBT5IrH8RYhbSdeKVjHmSyy6ibfrCnU?=
 =?us-ascii?Q?RNe1N09m6rlmJetntdgXxloMsZ9zgKYPHBGEmLQ5VCKO4kIajgzqI/zs9y8e?=
 =?us-ascii?Q?XTDqu0hkMQjvRYAD+CVwV2yTwpQVUUbsEamA0AbKqM3MaysuOmk7A3QM+3tn?=
 =?us-ascii?Q?/QFSRozQBSiCgkAqMqfFAwgVfPsTNjj0nH7ib/4dpIJvJovaiKE2rxTjO6zt?=
 =?us-ascii?Q?kRHboiB7gDrzhGIUPKw3M7yDGAHKE5IrOiLSpH7LcbGI7gI5pL5mUopyYtLu?=
 =?us-ascii?Q?kfr28cGhRn/egYgRrCA8dkHbODyvq3Mq4lw+/nqMdiTHMfPBgLCrfNpIH+ZQ?=
 =?us-ascii?Q?DZ5KE1ooeckAeYxif+ikaKEFO16THIiW4hgLIPIWNrBS0X8gfsRvJJxKL7kS?=
 =?us-ascii?Q?htT8EJl7/sPF/i6Rv20RHTkw5OvOP9y9InOWvRE7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1168e26-ec83-4bd8-4ac9-08de359817d3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 13:54:09.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+cNFwo8B9W55AToewLzluXCrogkm+qtY2/qPnBQz5o3/hNISpWTnlvzWZJONOeXxhDdxdt75CTQI9EaStsiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573

On Sat, Dec 06, 2025 at 02:22:03AM +0000, John Stultz wrote:
> Early when trying to get sched_ext and proxy-exe working together,
> I kept tripping over NULL ptr in put_prev_task_scx() on the line:
>   if (sched_class_above(&ext_sched_class, next->sched_class)) {
> 
> Which was due to put_prev_task() passes a NULL next, calling:
>   prev->sched_class->put_prev_task(rq, prev, NULL);
> 
> put_prev_task_scx() already guards for a NULL next in the
> switch_class case, but doesn't seem to have a guard for
> sched_class_above() check.
> 
> I can't say I understand why this doesn't trip usually without
> proxy-exec. And in newer kernels there are way fewer
> put_prev_task(), and I can't easily reproduce the issue now
> even with proxy-exec.
> 
> But we still have one put_prev_task() call left in core.c that
> seems like it could trip this, so I wanted to send this out for
> consideration.
> 
> Signed-off-by: John Stultz <jstultz@google.com>

This looks like a valid fix to me. If the task changes any sched property
while it's running, we go through sched_change_begin() which calls
put_prev_task() that always passes NULL as the next parameter:

static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
{
        WARN_ON_ONCE(rq->donor != prev);
        prev->sched_class->put_prev_task(rq, prev, NULL);
}

This should be the code path(s) to trigger the bug:

  sys_setpriority() / sched_setaffinity() / sched_setscheduler()
    - set_user_nice() / __sched_setaffinity() / __sched_setscheduler()
      - scoped_guard(sched_change, p, DEQUEUE_SAVE)
        - sched_change_begin(p, DEQUEUE_SAVE)
          - if (ctx->running)
               put_prev_task(rq, p)
            - prev->sched_class->put_prev_task(rq, prev, NULL)
              - put_prev_task_scx(rq, prev, NULL)
                - if (sched_class_above(&ext_sched_class, next->sched_class))
	                                                  ^^^^
                                                          NULL dereference

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
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
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: kuyo chang <kuyo.chang@mediatek.com>
> Cc: hupu <hupu.gm@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: sched-ext@lists.linux.dev
> Cc: kernel-team@android.com
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 446091cba4429..598552f58f5ec 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2402,7 +2402,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 * ops.enqueue() that @p is the only one available for this cpu,
>  		 * which should trigger an explicit follow-up scheduling event.
>  		 */
> -		if (sched_class_above(&ext_sched_class, next->sched_class)) {
> +		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
>  			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
>  			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
>  		} else {
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 
