Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C919D06B
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675998; cv=fail; b=ckJR7r0VavzsvPAl2zkwEh9W4wHkd6O2oBRVlD9ynSHVyLZ2XcsO/qIUkGEqmUx5MsHStL6U2lFZz53WPn3Tc/TPxwzB1qXx5XTfb7hTuAnrj+FkOG+IhpwQmRh9Dv/Cir58lnQKfrFWmXBibj4aEr7mngi+X7X7F/HzO5hExzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675998; c=relaxed/simple;
	bh=I1Ai4m0XdpDGD9cTSqxbLjph1sr1fBs2j5qwIeMEhLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNMoqgqN6Gb9md4Ems9M3/70Ts1ROOwBbtiMsQ1RQ7eYnLGBbhOS4AdDzOBqw+xzA/ymslMYXJK2JUW1eSf0ILaO6G+AExSbnROpZIRJlxiqsgb6KqTFWw5CXw6uUBi9/bQ6hg2C1tAG9qGAyg7oIcEZ0RBJ4j9OVmwunATgrnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUwoEVc6; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUwoEVc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3W3CMrKgqqfyaHP7tHwtQWRt+wfPoejmhKIEZdnqxXlaGIpcqYbg0D4QcdrVO1LK+j9n87EyoTCYPTBRrSO/pAlEZROJbTBO1Hd+JRw0K77AqdaRqejPZlGDqvxMSlv12iSP9tIQ/Tspp3tu8TEuiaU1i/PnmhQ+iEuCJGJI0AaXXOZB/NDYLoEHHQIi8ppSSccpTEWeIQXwcYqRcf/NVtUjyihIag+0pfU5vdeMk0kZSm9ICT80AOISrno8uIHAYjjydIDDiHGrHlju2lTQeis9duqt9MjLrjjJsinvWCAxuj+vNW8BWCWZ+gXOxAvwYl0vyhBjHqsRG84ILXSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seel2Z4JKtszoBpy4oUla+bkcrJc8kcGzJDlon1DhJk=;
 b=nzqTEOou5OZs1mila6wmN3kKu4nVVwPvRGLWxpHcQ2JQKvJpTomsK6mzNi59gkAhl6c03PzncAXe1yzXOePKFAiBoWgOU9LSsFlykAODWXpouij4EAjAzCFmvi9hfHW/rCA+J8mVyIfAtJA1AB1mCsBHh7kVjULHvlqv4EqAH16HixOD/ISBVw1+Inu0LSBBWTRbOPmTlV/gLM0mVPkD8lLMFAZCCBXwmn4RH+3TuUTDUd+eNXsF6CPdwrgKixm6KMysBkBIEReWsyscO9ur4TAfbi8ZlRxPfIY7S72+igIcfWpjdyhnYH8geUp/6tL5n0Ts7cZ6dFRmAUrl0OarQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seel2Z4JKtszoBpy4oUla+bkcrJc8kcGzJDlon1DhJk=;
 b=IUwoEVc6Fmznxtu5sj/k4ylOXA8eOi9BEmU5jCyEZ/vJKK12lWiWJT249uAWayQT+XWxLqUoz9l9JCfheK5dvfqtskIf6nIj7AXVZ7rW9yT/RVo26iIQeAqc4QZY8yxU5Iv5MFo/xMUpw+xjoU8rmtPelLxQq6cZeOdJNzQBO2wL3L+/X8RmlAa68bhsqqq2cZ6IVzNtCnef7rfzh3P8+Whbhn6dCx+SUpoXxOGxF9KvNX1eZkAaz77/ANeQKAfeSs6GLXj3E8mV7aT1LlP3ldFYCx7iXVLtpSpDT1ryUwAIZRMp1G7oVzbR6mDhEzmoGMpFBhc7K74uyE5yKIqbVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 14:26:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 14:26:33 +0000
Date: Wed, 16 Jul 2025 16:26:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <aHe2j6pIyQiBf1S_@gpd4>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf6d8df-6a4a-48e0-186b-08ddc474c361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ri8SfSrOHYfoex98QbptoMZf/383d5CCkkHLjDBt/92Bl4MJ2J8PbKKzY5z+?=
 =?us-ascii?Q?XTOLEvUuIuacKscIS9QnVLNBnSPb6WTqOvm4NQA3cK9KBUsb0To0qwV15pwR?=
 =?us-ascii?Q?vVbUINjGfz/iUFgSgoc1Rvt1sPOgbbPkuNbSKTao2EEuR46hGtmxn8HdweKm?=
 =?us-ascii?Q?Q6Vsudcf1nH80fH94I+IiiWd0fSeN4SvTbrK5E8d0PliAuzXt0k+C/6IqxzB?=
 =?us-ascii?Q?qg+JUtYyqkSxHAFcURD9FeBNhKU9N6hnWWRFytZc5qvjYpRB33JcREhL5xAB?=
 =?us-ascii?Q?CA74bmR9hRTLF8U3AkDTMmQjm2bFG09X9tjPIaEVv7EUq9FFr+L3tGCHyyiA?=
 =?us-ascii?Q?OHV7KqYDneBo+nctirB2UPmgTZa2xrlWpdZvfp+zywNqkxksvf5taIwaRu/Q?=
 =?us-ascii?Q?a27avTmcterHwo7Dnvv2rDSOyUrlvvjQRdXnK5Yp3W6jDsk/HohCGfwqm4jA?=
 =?us-ascii?Q?U7fMuGFk5QpdxYsdIMGz4MNHqp2YoC+0jLOXD07XMlkZlFoybyE5QrZtg7PP?=
 =?us-ascii?Q?5e3r7QOrSI33e2S0qlcz1El0V36cCzaxCQ03kBnCZasoJaeyy6yGH+Yuh/7c?=
 =?us-ascii?Q?C7C5NYSbkvass+ezJEfL4+0E9UbRvHJ15j/LV8Kl8aPlWexUjlKvyG0S7TYP?=
 =?us-ascii?Q?b6JGV+uJ78OEHbima5z2OqqykuJyHa0Ig1fFwE71kL3gbnDuLdn9EXLBPixn?=
 =?us-ascii?Q?bZr0On8rIQ0W1ZCee0H9rUcBt/IP3TbJXR5PuS7BUzC2EepS5rld2gX7wIva?=
 =?us-ascii?Q?II56MeXdo6Vd0mJm9/bhu8elwPR94+HrUVa/dV4sMjpi1AxX5RawpOHHjGMP?=
 =?us-ascii?Q?bl5jTBQ5G2pRnhcKo1MmdKC7wqPfHBz7P1xyPuMx6XSmqZQ0Br/mBgHGZYHi?=
 =?us-ascii?Q?ZlEQpEPJ40vMhNTjjI/R7+RawA7aDp+bmHlofIwYRIwZQN2WaJidLuf2QJwy?=
 =?us-ascii?Q?Q1X8GDt2ecQbGz63eUcUaJgcG6HIqOxq/4vbfyxFl2RzRAkOAKuPlvbPp7Yk?=
 =?us-ascii?Q?BogEAU91dPBzqD04TbW+Hrh5De0mrD80jq+vu9ibViZJWdZQr+IeNgWCGFH2?=
 =?us-ascii?Q?xZyhS6UNBWaVQgduA2G2u2k1aZD/ZyRq6rv5i5lEnoFSLLAKuf6ZQEcKh7wv?=
 =?us-ascii?Q?NAx8uq9wNvgtqRYVdt21sNyH+MQlTdQQIOgBoMaReE049VULkNaTrBXHdtou?=
 =?us-ascii?Q?ncwqtw/y3lz8T1XO78E6TTrgwKTNCm7infTa+chdY7gN8vDPsOZON7uqh78Y?=
 =?us-ascii?Q?CL48R0rIeqiD+zbWXgnfEhEigJujdFWalUlTJ/4or9AMIgFoHluXLyKIXdix?=
 =?us-ascii?Q?lNwoQe3+liSJsF0iasrEjCOuXobGdG4G/g66KqlYJ1EFYt3gAjeBlfn9RUQ3?=
 =?us-ascii?Q?wjqXz0BB8OoswLlwVN1ohPiQbT9dq9BpMPjtf4zU3DLpn9yvPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbhyL4EheXZ9kjH3YD/jSdvoZX843PcxbPfLVh4sYnc5G8HI5zPUCG/mnbTk?=
 =?us-ascii?Q?On+8EXuo1kMGoMEGRTJMQKELHy4pYA8GIGGNJ8Q+WHTgTjyYevPZLD6NsvZP?=
 =?us-ascii?Q?0psDV3fVZHg2TYEsqz/yWql2chVPyGHzQqDbeuVLURAse7D6N5potrTp4AfG?=
 =?us-ascii?Q?lGnWGMxbcuWbuYdyLGw6MGpE82SowxFQ38wRg6utKMddaJy+GdUGLQ0KhPhA?=
 =?us-ascii?Q?AuV1/PhKlZheN8gM/kAU968Me9rlyEdGlj9lJPlwwhaOhyIpf9YkM6SWAobC?=
 =?us-ascii?Q?sV3DYfXFIEQEftZmmRV24OBMNvRa2FA5HHRaZom6+SfVlWEqp1u7AFIRXFjF?=
 =?us-ascii?Q?8XrNVu4ykzu7slDse4lrSWKXjlbj3BiADkvECYOJD9QueWfeofTq7iswvhLE?=
 =?us-ascii?Q?FWJsdyz2IBF2IbBp6qnp8Bz7tjwUDT+pp+qG5Op5nPukX3IN5oQummf6R7QI?=
 =?us-ascii?Q?pNl9tCxcdh20jXXjSJqGmB+8qcYlBWqkjNl3+ROEh7n762o1FmOjxQtCDGAU?=
 =?us-ascii?Q?qBcKadCvGq+KlDahLcIdpxgfRXjiAHpmkgu+yvPNVm/C7ltBtdDg5jGsBYsF?=
 =?us-ascii?Q?HxxQ8JMtdZzTSnVYxya/dLmVx02CA0W7TqGH6DkxEqRa27RBMScA1yJypI/G?=
 =?us-ascii?Q?eSln/QtEW1aiQVOpb5LgM0VKm8Jr/3Tjy5LDh2ilpmQFcBIvnaBBl5Lbwo63?=
 =?us-ascii?Q?rklDcS/xusvopgTkWE4wyqFosKshdpJqgW7ZiLV8SHwWF06Dl4aouMKcJl95?=
 =?us-ascii?Q?wfDLgt1xkIqygIRcIkzNj/Y7/itwa08CZXE+kPbnV8sxVH6hHmSqXYzzrAdD?=
 =?us-ascii?Q?IrwAIIcnd/BIt5jaZJt2pkn0Gi0y1OVlayIMShqH2do95IJv9XG8peXpL4ou?=
 =?us-ascii?Q?Z/tFdoymO6zb0bqF/dy7i2c+Zlqml7TM1Uv9U5B5C820ayjQAcYa3Cpy++Yh?=
 =?us-ascii?Q?e2draAlxv3jLqJdC6bivBHz5rr9Ww5VEtW/ULy2YvZqh+QG41sKGPbKvbZEm?=
 =?us-ascii?Q?rWIhIB++pBUF3oHHhpiqWsvCU9qxa84CqEH3mo47Pvs2jV9kH91OZEcKdGrA?=
 =?us-ascii?Q?TqCBd31ptzYpLO/NRgEB/38VfHEsya5+xHF9YVWg76EjBcvLuv3nopHqKtbA?=
 =?us-ascii?Q?Z6lESMqcHegPvHJ49ke/aTGkrdJ8weaV0dXEBXCileGux+cZny8GHccdDKTu?=
 =?us-ascii?Q?ZehHNusQvk25VKmmCxfyA4mwyGORKZBQ68HgKCzIwZr91gsWiwfQTbAT+br4?=
 =?us-ascii?Q?1yg6MkHxhZQ3gigcJG53qXObXSQforcBlgUWRvoVIBYEgIH4I80MPxifsIbA?=
 =?us-ascii?Q?mDe4IfFcbKJojzxnf4l5L+1UohJK8PafEOHSHWczDebcLtesesGyhVDhkM1f?=
 =?us-ascii?Q?e72fkiIyd3SK3iJS2khzCivfB8TeFnEm5IOwAK02/pTEdTWH6H2bZdiC2Lj+?=
 =?us-ascii?Q?3ibmhLVIiPJOuox6mtd6ZiwQIVHD+a/wf2Q7wvC6ktP2XDnyznq8dIAQAitX?=
 =?us-ascii?Q?4L7jImLjZ8j5N36kGf6OWYBDcoNPjQEUSzlRAwvp9pQlb0qSwLuhdUDCrbVH?=
 =?us-ascii?Q?UGm16vJli5nVyVZOnkpXctmuDViQukb4wWVrz97I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf6d8df-6a4a-48e0-186b-08ddc474c361
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:26:33.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBgxrvx6XE1sGEgKrtE2QtAVZEfx+OLNgGEh5FG5aQ/y8SJzyp4tjmvgkrlZud33ieE+BMxR70N8bi7qYLfV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

On Wed, Jul 16, 2025 at 03:36:31PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> 
> > The idea is to track the scx callbacks that are invoked with a rq lock held
> > and, in those cases, store the locked rq. However, some callbacks may also
> > be invoked from an unlocked context, where no rq is locked and in this case
> > rq should be NULL.
> > 
> > In the latter case, it's acceptable for preemption to remain enabled, but
> > we still want to explicitly set locked_rq = NULL. If during the execution
> > of the callback we jump on another CPU, it'd still be in an unlocked state,
> > so it's locked_rq is still NULL.
> 
> Right; but doing superfluous NULL stores seems pointless. So better to
> avoid the store entirely, rather than making it more expensive and no
> less pointless, right?

Right, we can definitely avoid rewriting NULL.
The following should do the trick.

Breno, can you give it a try?

Thanks,
-Andrea

 kernel/sched/ext.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e231450768897..c76d6c9e497b4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1290,12 +1290,15 @@ static inline void update_locked_rq(struct rq *rq)
 	 */
 	if (rq)
 		lockdep_assert_rq_held(rq);
+
+	WARN_ON_ONCE(preemptible());
 	__this_cpu_write(scx_locked_rq_state, rq);
 }
 
 #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		(sch)->ops.op(args);						\
@@ -1303,14 +1306,16 @@ do {										\
 	} else {								\
 		(sch)->ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = (sch)->ops.op(args);					\
@@ -1318,7 +1323,8 @@ do {										\
 	} else {								\
 		__ret = (sch)->ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 
