Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC839C631
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113475; cv=fail; b=Xc7lGCpcDtkBUUqU1rF/snmpH3muIPlGBhxZuvJHi6qJYshqkP1nd961gd8afFCkUeRo6mIXOICgi1e5nNEgGDuCa1IKUOhuzKEX5g1pEcJ/VYr2o9rjOAW3Ig/JnKsy4Xk/Cbo/1X1tqdx3Jx8EzD+o9eM8kFqiEyx2aMHeo8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113475; c=relaxed/simple;
	bh=/CMHTDR2mxegDtE7YoeII5mTWq+5GmND5QHQ/L3YU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhdelmimJZspTUMyE7gLCS3nlcOANIPslJQD3qy1zLoET71P0MHujezirJ1Ebncyk1cVb5pusfpOPQ/lm3386NgT5TrfhosB4r3fNVWEylMJBAtEtb5Q+an1/jjDqpalgMhXS9Prm0jVggqeQfhBnLBjqclFP6DksaYAwrSu7R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p7vzlFTD; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p7vzlFTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9/mTJ5pfrA61cgzI0ITTdraMWdFVe2twd50hO9wUeeTyoJQCg7YShfujUXCtKeYmK8h7y6Fed/5gPiVATejHTraJZu1cl57hu6ecO4EKVX+kScj0G5K4G3NWZZc9PF+f3jvX2o8UAC1e1k54MvDQrYK/vboK2mJ/2RdBRn4ldTcrXHtyzlHaigiEYHVfh76H2S87cVaDU+GDgWolIc2l5ANCVKpwgqPE/cuUiWSVCPTtdtPBKbgsEKejhTdcvGsg0S74G76FCmTzvJhcws79MuvkvKPGcDot2E0HNjkDIe+DOYi7nY2rGIa+PT3M0VCBDFQVa98lC0QQJBWSK2L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtuWbd0gL/5t+miCkS/WfgnINc8PByjzpbItWfYlnKA=;
 b=ukjLrnYeVTCIu1LiSw1KKtKd8W6DkMP8+6oU/U2PLGmPgjjbjB+DJZ6ad6TLF4jFU/9g3LsFDIamAEOjC6qhAOziII17YUYJApk5KrZW2jN2+HL5j2A4rborJ+ZePokMHM97nkP5VJCJe14+VIxibisjAkiQi2CyiUHpb1aTqGl/qjDQYqrwBFbUrarFgBoWAENrAIHeIqpwKTNOP0qgre1EGaBOzXbsZbZwdvUgT7BLcD0kukYz8adW/7TZ38lDxZqURAFePDIrxKNKoY3yqYP68Ibw1pTQytBsFYQK9KqldRaVRzAYFEDhAjjPpAJow7NlIka6VZ7H/K/i26/0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtuWbd0gL/5t+miCkS/WfgnINc8PByjzpbItWfYlnKA=;
 b=p7vzlFTDB+G0PVTKY1MqTKDvDL1T/Xo5ruBB6ajP7VpuPTIhCBtWvKppheJ2QMYxU+VaBmK8AHVARtBqueh5vywGEednyex/ZEDlG5VKYzrCIUmKvJiA9//+SVYQs6M89wD9Onms7lperNkMky3sCaIEbQAuLYTDgt4QxAVdM1sgKqpybEx3uGEhZNYXItGRqEwEjNzeX4H62iXx432RjkGLVlOQD8lXYSkWFkz1fxQzYV+wVoNLmwL2jSXesjIOwegUiw2g02GSW4IjF4wyTN1d4CB3JT1/Lw6giUCSJvaqnL+aHS97gls4gf3u1a1hQWFCDFPJEcIuaQYBDDCX6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:11:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 10:11:10 +0000
Date: Tue, 3 Feb 2026 11:11:06 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aYHJuvVaa8xNbuHR@gpd4>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
 <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR2P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: ae25193c-ccc4-4382-cbb8-08de630c8dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?No1tISQb6Bsg7NaWiHDjkMU8OUTPVRQh5c77YiSzzmfvKoQGmbxWER/35/sW?=
 =?us-ascii?Q?BITu7OgW5VGOXS+qyF+dKLgNcrwuZ6Vh130EKEcdQi+KoinePsr5NMEmjPYB?=
 =?us-ascii?Q?kVDlkfNep45gAaujdUt0pb+e1zTLx/90k62MeZctdDd2ytygqnJDWjMA/E8l?=
 =?us-ascii?Q?mm5XgglRlE2HvXwvy/S82uVYXAgCfNCc1oOblkiq33f5Jl7ZfNSRZC5OXj/I?=
 =?us-ascii?Q?ZAEPvyjEmTQacavZ22g794pqKB/C+X+CdcyQUKyBDjRH8wHzV0OtXzHNgtlR?=
 =?us-ascii?Q?eWUO1yPA5Acx2LU4ysUnraZGWz+DCXmp2R9OT3ZpebdQv6KALU0EQomPh6o9?=
 =?us-ascii?Q?rBc0JIdfH5rL9ZazZ3jle5au9LEFdbi7nURflrJmhEcfIk+yo/R3A3O6VC/S?=
 =?us-ascii?Q?1np5JNAZEqvaz8HDmSpKNa0KJeodBVraCEdD7vN/zwgoXI7ccl93KKIjySYb?=
 =?us-ascii?Q?Mz7zwjFg8u5YsNfUHxcpRUft8tnu43UThC+aMpfK0gXwIWLvnoIexRsoMopo?=
 =?us-ascii?Q?s+w2xhhXQvU1u9WXmFKsIT4WpqQf41HGiHu/RbXC1WsR5F+ejSOgGgns/GWP?=
 =?us-ascii?Q?Otp08vybxe2S8tjqZmfLDcQhIZzyaH0+Z8hmEQ4sPVLlKVE3wsKTyi14W2D+?=
 =?us-ascii?Q?B1IUzkQrC+Q8eVq077NOH7ZBk4P1V9Oc7KMcngCsIqsW5EEv0qUxe0VdfTTv?=
 =?us-ascii?Q?DneX0WxxIzaDzcWLFf7lWlckkMLMv6HbU8E1jRRxMk/OdBlzKZeT5e55N7Tm?=
 =?us-ascii?Q?dXbBpxXimrO+wPO2bZC3nVDxeIUllgHY1rbHC8NUVheHPEnF6BKI32F39RN8?=
 =?us-ascii?Q?XLzkgLOnstaaP8+YCELBfl9P06MyEhMWQLwvgACkTZDHdUJ5e0DgyR/MPWaG?=
 =?us-ascii?Q?1lPYsUGjPqGNWzTr2m77xWlRsxqpY4QhONDetAN9WwvS1qpE1B6Ahn25HyCV?=
 =?us-ascii?Q?D1yp4QLN0aZeidJ8fGVL4e0a4cgYBeiqlL17c2W3Dy+4frqKh2S0KRqiV2YQ?=
 =?us-ascii?Q?kBogaWB/K36ST79rjDFt7UCxkHa2VILV83tep1sUS+UrwrZ5ijE7y3s5NOsS?=
 =?us-ascii?Q?0C+Gba5+Glg3WwM/iuOM71tKawPCML6ogjHWsTO4CJwhh6B4rjP6bjXHUNU9?=
 =?us-ascii?Q?OzbEVycBy0RjOwPwByKeN+2386A0a5sALfYxwy7zA29fHFliyxeiHclgATFS?=
 =?us-ascii?Q?a6V+oa36/VbKQPYgn31PaR5r2Ewv1OFZOSAaJljlo8dAUGfOv4O/SGQiqKct?=
 =?us-ascii?Q?2MTXXkgPMjYV43rTv5Y4HVWt6TGSOkP8TOiYCp4tCCJ/Qf0Dj92zhFO0QBJQ?=
 =?us-ascii?Q?WmfpgidzNqyG3GefAir8AqiAgI8NHOnAV7R4JaxHmkzXSbDc5G3Un8CWUWUI?=
 =?us-ascii?Q?7fnW1zLEGejNB7Ozqg1g2b8mi/c3Bh3d4CQoqiajCDl3IoNZYpEYgD0bOiSR?=
 =?us-ascii?Q?jw8tR7+0JWdgbt8FLKCShDCfFXDDBT9NvuB0kmhTC821q3/UVghBTYXLbUAu?=
 =?us-ascii?Q?R5Q3Sp5gCXC1QieParVXj5+mlUZAEBg0mPm1Y6SVZhWbstB+1Q9TPrtdMGgz?=
 =?us-ascii?Q?byC5egKXiONjyt3cdys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rlRfdmg3zwVs2pfBF0p8lkgT34t8630zZastSxViqjR6o5lfmgu/GMZPuGE?=
 =?us-ascii?Q?IwCXYk9F9pTDjte4C3Rf+e27ni+oIo+B9R3iQw9CSC731Ydwq6a1JHCkjjLX?=
 =?us-ascii?Q?2qqG635R66o1mq+rTQ5hxmMjpLML6Tr5LYhAUntRN1OyYOkdn7JsY15pJcNw?=
 =?us-ascii?Q?vWf8Q6cRzE22CXIiAGiUgqcGIZyKSqs9oC6ellbzWgJV1xpgZjfUGZai8rYc?=
 =?us-ascii?Q?Q0yeWXWpfEVOc6/fM+zZQ0Q4qsjZ4g7gZmtcOAVNM7woZQyvIC7MGa6GVMAG?=
 =?us-ascii?Q?5GwuG8fmshFmhTDrS54WTzAVUnSpHpoU9dcjqaUe/Yaaf/Fg2/C1WhOKDTpH?=
 =?us-ascii?Q?/FiCcFF17YMF4e90/T0OxMY6wWaU+orADyR7xiuR9zqohw1lTVwGuZXDUMYn?=
 =?us-ascii?Q?swM05+QoyOjwoKOlTxn+K9ygwR01ZXiZY2kgsO6h3c2KlR4pmXYxK2d/8YHc?=
 =?us-ascii?Q?IPw9qL8zA9DDz/tIo35/3+UyWFEkE4vlLpDtAtDxsINEmvH32piZhoH2rFJl?=
 =?us-ascii?Q?OETQRRw0EYSJq4wTHuWPP1pboa5+IO3Fb6KwAoOAkwYb5zpGKJvh5GQE65Lb?=
 =?us-ascii?Q?dwDqJ7uh971rSVowGBhjx7+7O6B0F7G0gLMPEEehGxiZXoGtcttjKyKulvbQ?=
 =?us-ascii?Q?JsVDVbiNyOGnze1S73W7oga0RT5sHLsZAbIH9+Yod616V30pmYuLjRvZm3pC?=
 =?us-ascii?Q?jJQpGzqnk1TFxey8oo87OvEsU85zIj7NYG5LZXq9FQqf/Mw99YyIm2lBj0EZ?=
 =?us-ascii?Q?g1Muwmj2JQN009cPSPEwxebXxjL4Xdbz28uFMF+VEZuA+vg6HLDvWhGFGG0w?=
 =?us-ascii?Q?vVi9zmmyrDD7ny2HVBHwWZceeb5YmGqWAOB4fJd/rsHOtH0qDLrO3Rbtp8O7?=
 =?us-ascii?Q?Pmjdimsl88J0/xlf4WRCJmWsZ3b6ScbBg7g6T1qAab8bMwELuc2VUXgbh5xQ?=
 =?us-ascii?Q?rNwqMwxKgeY0DYcJkwZTKweuUutSMLGnHuBD4WCiB80jJ83Ro43ns+iGpUs9?=
 =?us-ascii?Q?iwX0uQXsg51o6iiH02qlWEDCpoDmQoT0GwCxdavVp0N+FbxL8aSQY4FsPavA?=
 =?us-ascii?Q?PCrtadp/wKrksT3HfuK1i838MnmCvXl9j/o957xVi3XcMRfCjayLuEtDrMDh?=
 =?us-ascii?Q?/3lZnW4bVmWJaoWJyZR43jjd/Io1Pjc6DvtTBTJYWEKmMcBw1OmiZgXyeBfE?=
 =?us-ascii?Q?zrx4gLW6wXQ4YMJ5FSK/x+aVyg14kemkb3aSxbjiP5Mofh+uD60Zk9bGVQsF?=
 =?us-ascii?Q?buuQQ2jWf+N2qq8ihrRFOO9QSsXEJlCF4LOsqgPbo18aJ4FPZCtsBcItuzuf?=
 =?us-ascii?Q?tUC0jlNWW9tHiUy26sDjJh9VhvCGhlEvE7dS2ekmxZOHZ5ZwuPzdVz0nGGb3?=
 =?us-ascii?Q?PB63xf3puZS3HSxn+20iml8AcHebAItupFxnK+YqSuOOeusDb3txzvqL4LwN?=
 =?us-ascii?Q?kYQy4bo1q9ByAx3FCG3gQHaFG83YY8yr+usOFh/Z+OeIEmecJ/2zzXbTeN6P?=
 =?us-ascii?Q?RhVdIB6lOpMmbEnqWMYQbyihAYKbIvKXrtBmLQ/h0xN2gKi20/7hzeYpvXnU?=
 =?us-ascii?Q?CqWzrDYO0LHprMcUlOodCgRWP+sYkzcreBTUygvCYCKTwHOjx8W1fSQtlxti?=
 =?us-ascii?Q?wNJ2kLG70y8eCKVBPGJbK2hy8zLiG4ZtygzvOI3nv649BXreUdDKd7sdK5Ww?=
 =?us-ascii?Q?+s+P3ur6sdRzaIcsSct3ATjFcxgSiXXn2ZFaMTZMMt13qwZfv7gQ6OTbEtdd?=
 =?us-ascii?Q?DET+JOKnVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25193c-ccc4-4382-cbb8-08de630c8dbe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:11:10.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AJtFeogVFBYIj6owAzy08MZORmLd+e17Hbg9G7CveP2KNm/EcidnN87CPD74tDoSWsyHjRYd6b/PbUHbGQhnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

Hi Peter,

On Mon, Feb 02, 2026 at 10:17:23PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 10:13:26PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 26, 2026 at 10:59:01AM +0100, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Currently the DL server interface for applying parameters checks
> > > CFS-internals to identify if the server is active. This is error-prone
> > > and makes it difficult when adding new servers in the future.
> > > 
> > > Fix it, by using dl_server_active() which is also used by the DL server
> > > code to determine if the DL server was started.
> > > 
> > > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/debug.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > index 93f009e1076d8..dd793f8f3858a 100644
> > > --- a/kernel/sched/debug.c
> > > +++ b/kernel/sched/debug.c
> > > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  		return err;
> > >  
> > >  	scoped_guard (rq_lock_irqsave, rq) {
> > > +		bool is_active;
> > > +
> > >  		runtime  = rq->fair_server.dl_runtime;
> > >  		period = rq->fair_server.dl_period;
> > >  
> > > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			return  -EINVAL;
> > >  		}
> > >  
> > > -		update_rq_clock(rq);
> > > -		dl_server_stop(&rq->fair_server);
> > > +		is_active = dl_server_active(&rq->fair_server);
> > > +		if (is_active) {
> > > +			update_rq_clock(rq);
> > > +			dl_server_stop(&rq->fair_server);
> > > +		}
> > >  
> > >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > >  
> > > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > >  					cpu_of(rq));
> > >  
> > > -		if (rq->cfs.h_nr_queued)
> > > +		if (is_active && runtime)
> > >  			dl_server_start(&rq->fair_server);
> > >  
> > >  		if (retval < 0)
> > 
> > Suppose runtime was 0, and gets incremented while there are already
> > tasks enqueued, then the above isn't going to DTRT.
> 
> Something like so perhaps?
> 
> ---
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 59e650f9d436..884bdf7a292f 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -340,7 +340,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
>  	struct rq *rq = cpu_rq(cpu);
>  	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
> -	u64 runtime, period;
> +	u64 old_runtime, runtime, period;
>  	int retval = 0;
>  	size_t err;
>  	u64 value;
> @@ -352,7 +352,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  	scoped_guard (rq_lock_irqsave, rq) {
>  		bool is_active;
>  
> -		runtime = dl_se->dl_runtime;
> +		old_runtime = runtime = dl_se->dl_runtime;
>  		period = dl_se->dl_period;
>  
>  		switch (param) {
> @@ -382,17 +382,20 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  
>  		retval = dl_server_apply_params(dl_se, runtime, period, 0);
>  
> -		if (!runtime)
> -			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
> -					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
> -
> -		if (is_active && runtime)
> +		if (runtime)
>  			dl_server_start(dl_se);
>  
>  		if (retval < 0)
>  			return retval;
>  	}
>  
> +	if (!!old_runtime ^ !!runtime) {
> +		pr_info("%s server %sabled in CPU %d, system may crash due to starvation.\n",
> +			server == &rq->fair_server ? "Fair" : "Ext",
> +			runtime ? "en" : "dis",
> +			cpu_of(rq));
> +	}
> +
>  	*ppos += cnt;
>  	return cnt;
>  }

I slightly changed your patch (see below), adding a missing
update_rq_clock(rq) before starting the DL server and updated the pr_info
message, as mentioned in my previous email.

I ran some tests, and with this change the DL server starts correctly when
runtime is changed from 0 to a value > 0, so this fixes the issue.

Would you prefer that I send an updated patch set, or should we apply this
fix on top?

Thanks,
-Andrea

---
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2e9896668c6fd..dbd5e67a16c67 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -346,7 +346,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
-	u64 runtime, period;
+	u64 old_runtime, runtime, period;
 	int retval = 0;
 	size_t err;
 	u64 value;
@@ -358,7 +358,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime = dl_se->dl_runtime;
+		old_runtime = runtime = dl_se->dl_runtime;
 		period = dl_se->dl_period;
 
 		switch (param) {
@@ -388,17 +388,23 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 
 		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
-		if (!runtime)
-			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
-					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
-
-		if (is_active && runtime)
+		if (runtime) {
+			update_rq_clock(rq);
 			dl_server_start(dl_se);
+		}
 
 		if (retval < 0)
 			return retval;
 	}
 
+	if (!!old_runtime ^ !!runtime) {
+		pr_info("%s server %sabled in CPU %d%s\n",
+			server == &rq->fair_server ? "Fair" : "Ext",
+			runtime ? "en" : "dis",
+			cpu_of(rq),
+			runtime ? "" : ", system may crash due to starvation");
+	}
+
 	*ppos += cnt;
 	return cnt;
 }
-- 
2.52.0

