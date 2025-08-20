Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354181DDC33
	for <sched-ext@lists.linux.dev>; Wed, 20 Aug 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705148; cv=fail; b=W85M8bXmd+SStmMqLD6Cx6xGXmANKF4vC90auQ6m0a1F35tJQPVKB2U+iUNOcYi8VfWPHe4ThqvUS0JxxEEgE6rh8KZbOY3CfZKzUdBQjbIHNwMQNJG9TmM5XgWjAcwmYi9E9ZVemMrYz/P3hgHozliZAyKjJNA4JuYfadM4bt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705148; c=relaxed/simple;
	bh=tAFcJ9FvG+CWVvOHSGcPgkf3VxUu1/bznJwcuuibEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iuWNYe477cqhQAJRN6E86IKUDMmGYwxFzQnmrCl0h7mreiOCYesWCbfzw2kOWrSLdHs+0j+ZNevekZ3f+gE/UKbt1Z3n+9ianX4oPSbJWaZnHMoS/ChwRVamqtHIsxBuns/1Hl42KrTP/n0G9hLGx7YmgSezrc/BQOanudFk2EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0iSU8wQ; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0iSU8wQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBwAXZxRp9TbtwqjkT2A/4d7RTtnE8OtTEGauJBBf5hQuXDxjzeCMH91ThW7O8LDswwW8NkZegwZb810OiPPj16nLuOabYERerayW+zzb73/QseLrcd0uQwhQdlFfNVp1/udLmC8RVe4FUoQ7RUz6o1Ztwf1kq2vnwMDK4a7RMxGbhak4yIS3azjYHOLqHcA013eSdQSkTbDgBObcCvphuBio5FBoRC/xd4YHFXnDOZjLgLlRL2HcekeSX4in1YicLyk7fOwy5CXkuTpQTDOC4jEZvT9AAL6hAULOVGeiyJPuQr5W0f6NdNSKIQ2Q2ihrE7NT9HOYerXF11Nr/xuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFTbI9ND2CyE1tYPzE40lpD55Qu2t/EH0KBRykBJyRs=;
 b=A45z62pzzv71/qD1htOkLHYJe+AXBAjBJyCIQKvjwHOdc+yN5sm+tTLX+iskGEVP778EcrV9wvYMv/N5E58xINo4+V8lWhYT2te1LCTNocvh0CJTgzP9w2ubNLAu87dsDu8kTUorkbVhxOME62y0FVweRBN8IZRN1DrpRCsBy+VeGu+6JYD7S6Il2OvGhRXiZ2GDmtglgMKAMDTJuvSqy3Ta+YY4OUX92crTUgQQH2dpOVjY4V1l7o/L5JxZvq5kQS1BoINIqOsRUsrkMk1x6bWIM6RfK6YCBNUXcjuzDr7yA/KQRSJxjMqBupjgtt5BsNJ7sZWKtxmQ0GP+pBzEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFTbI9ND2CyE1tYPzE40lpD55Qu2t/EH0KBRykBJyRs=;
 b=J0iSU8wQdUzm7rt4QSvQyqGmQKX3IvplXc+FOUklwwaq753EJKFP54N/zh+VREi7hZjEowPtmRreLm+7ERRfMy6FqK+mczby6qNXb/Mt39APvJEItEpJ67MvaqjFxlUyjoz9IcaLRILCUwzr/rHzJLi2TmzJrbS1Znl4lu+I7e1Ws3XG0nSRw2JIar3HPCRbnhdCDpsPpcnv6gZCOxHLTUICIE0pYQ7DqT6xh73b4NpOvCdfq1wZOnkBBwaEPXybS+4tRqD+HsYlGB5lxHTvSchiuqI7OtdRyEQ9JLSxCmBioSpNoCu7CVXwNowGXiaW3tiMgSXmjL8OHX3b4bgjig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 15:52:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 15:52:24 +0000
Date: Wed, 20 Aug 2025 17:52:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH -rebased 07/15] sched_ext: Add a DL server for sched_ext
 tasks
Message-ID: <aKXvMAdSvNcVAa4O@gpd4>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
 <20250809184800.129831-8-joelagnelf@nvidia.com>
 <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: b782ab05-5f7d-49ee-9223-08dde0018dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uqxopv5zlUxey3cqh1UMg9t2/dhMTmdEK83dvs0wDV673xHQAQb2uAMk+S3C?=
 =?us-ascii?Q?+Gp2hq16AOU1aF/xu4EtEGTzX3O4+EDOiWFlo41+6Y65isGMXrC0dMAexkXL?=
 =?us-ascii?Q?NIIu+7whonRdixqKC6F6/h5gdeVQ8Z6Ew8epbuMs0A0mnACLDR5j86Ot5Y9J?=
 =?us-ascii?Q?j8tvutFCWrHOl8Co7LcmeUSGM606FVV4aaWNZfBx1UStrLVKj+JBGibJHGEh?=
 =?us-ascii?Q?tIKJFYRgC1mquzPMK84kRProDD1gCUslfgeu9F9eUhU1RrtNswmJ+ja0nFMA?=
 =?us-ascii?Q?t46lW0IS3LgwAYw9UklIVk8AgOOhRyXzfIsKQDRciKHyh480IdHihzpiWBfJ?=
 =?us-ascii?Q?awX7dSWtBLJchha9zpIICay0Z8V8ALsxewgfcwKk40NpntiBMvA1x64hm3h9?=
 =?us-ascii?Q?oGkSbZ7p67JQ80zyFkmsjddvg/tBoVk+d1XEpJKvfzrFgNO4ff/o/vgz84tG?=
 =?us-ascii?Q?hTzb+8WPrjIj16x+JzV4UgUh8tbzE+xBSz+fMRRnMeSm6bGMpauzCjYWg7L3?=
 =?us-ascii?Q?oZWXhW7ALkKClGjAiTi2C/ekAcA2dz+OuG6SfH8oBWl+e5IFSi9PDrbr3U3V?=
 =?us-ascii?Q?bSytaxRQzTqVym0H9pyprNUDXlIjLGds0L9dk36jBAPJH3cgfC6nsnjf0hpn?=
 =?us-ascii?Q?FQ0UHKPwwrEO02ryUR9kzaKSPX05A4G8L58dhuYMxSnLWpDfP0p+iwE+CqOM?=
 =?us-ascii?Q?qHSR8hlO4gNdaZeVSchNkVuuK7SAxLpdJOd4wNrJt9sNaXOFaQ30E4p7cR3c?=
 =?us-ascii?Q?S7NNLnx17ZQ6eicqvUeyUwe0gLc4HBq9b8UWP5I1Ah9898+1zprbZKVQI/G7?=
 =?us-ascii?Q?eqhMvSURGt6luEQsCWD9ZVg8CviIvL9SZGj+jhTm6yozEUiWluUt7EQStpFA?=
 =?us-ascii?Q?Ken3QK4IqW0TMJMsO1z6gMCnOPMdyvhPFLqbvrGUq0/AQ5sMnVEb3Te+4C9p?=
 =?us-ascii?Q?mFWUvBviza1dFhsCJ5Mwd4EjAFbSUk4ngIPuXjjrBzUWI3Cq78qrD6k7aoMc?=
 =?us-ascii?Q?S6+yjaLfzSws+QtGuAPdaRK6378UW1myWxyuSrQ6OaoOMHadjy+aw3tw7Yxx?=
 =?us-ascii?Q?tQFj5PDFpooPpLkJgRz5AoZPbdtjq5vXAGu4mpJOiyUUCVO9Rdm/K3iLPUkh?=
 =?us-ascii?Q?wM3se72jMNRCU3nZiidpVnNEGQ+ApjwdDJ2HEVtGswiK23bOha69i63KoN8h?=
 =?us-ascii?Q?FRdmYGGBqmqXwSkVZYK7zFp0lwUefouU1eNizPKPZLb6Pl77lUaJrqvF7AtW?=
 =?us-ascii?Q?6k0kAyTcvJepYnNWab2gdCwCJ/CjfQNijNmlPkzP2Tr1p4cHO7UUQEkrNdzF?=
 =?us-ascii?Q?8EuVeAXr5w5Ac4U/IQkgevrK3AY67uSCNXqctACR4Wmj4FBEO4kGTbjUHB9C?=
 =?us-ascii?Q?3JLgUal+HfGzoJvxifd+yfUAaIvVM5akZW9PJi4zia3GmR39uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnpVW/o3KGd0wAp5gnoK2yIKXbN0rXZtQzDpySfxaOyEhTAgBNQP+5MQJyOL?=
 =?us-ascii?Q?EPn/eVaonM3GaC6CrPFWP0rQMsllX2uQCccpn/I1RP4Br6gQMuQ+aqg8RRoF?=
 =?us-ascii?Q?tOMgDvM5WEJ0yLGx0eZ2Hgoj/QFNVNZVY1RKMwS/6ADYdStD8Ux71wDq1p3D?=
 =?us-ascii?Q?1huJWztHV8NLhYX9jR8aUkBu7ESDN+QMelUaU/xAHVU1OVO5GWufs9m7QP1Y?=
 =?us-ascii?Q?0Nb0LzBs2PA0zp/m24eaF8RdmKtvBd/40wlziDFLrKFhn2D3Y8y//DOYI4Qv?=
 =?us-ascii?Q?xZR4luqnKYLsSfGcW7D8cagP0OkzHFch3ppk/g+levagREw0pLjgGzprRLuv?=
 =?us-ascii?Q?NnIVbmAJpyjEO2sWS2SEKs4vwDYaKr4Gj8vrCPan7Un7MEQ3IXTsVX91ybQ6?=
 =?us-ascii?Q?A0Tg3Wi7FQeLKQJP3DK5AvM7zcNMe2G52kYb48TFkQwi67zPSqg4cu0zHwt/?=
 =?us-ascii?Q?+o1mfKVNpoFoElyGONTqba9vAVYmh5aaRKU8XIRwoxgEnJioW85wL5gFNYdb?=
 =?us-ascii?Q?RwPWgSZaxrFskbxEL//CEvLNDf9KHSArdG8KKHyJQdhvt9YBgzT2JbWW/lIT?=
 =?us-ascii?Q?RIyOrneBbDYK7RCn6QYj42QHhuQRQ6fojgY+ucpKwqq7ZRCa1/Qe05Gs/uol?=
 =?us-ascii?Q?kN2ms/X/EHeGqzEygvB6u/+5qeasEgWVxc8nd8/EcYZKrBWmhKRztNDFsxLC?=
 =?us-ascii?Q?UzRcytJaZpAN919ukclZIDcCK5cWu0hRWqkbRuaan+js317PN86VeTQmE92s?=
 =?us-ascii?Q?wAohn+pW+ikqh/O2lYofCzkAKwwsxkMLCrkicV7wpsnJu+UAIUYZBil2JRs5?=
 =?us-ascii?Q?dKozV2/k4A7rgIDMrTVk7LVBlEueffdKMaPh0LxYEyPcG8g1tBtRxa0R8c9Z?=
 =?us-ascii?Q?QsUnuK1NAfnRE3Lksm8rCcFW/K1r4z3o8OFmhPEohZZ3mDkfFbvzv8tqxzft?=
 =?us-ascii?Q?Okyut+KeVyeqmgi6FQu1Nxm9cI1aV1ZksEfiSoiigVgKvEQ9XWdI7fSb3ebP?=
 =?us-ascii?Q?W7rfq7YIHNyuwuOG5J8z/9mknSUVdr0Zk2ENKhXvOxrixpaPhSfL+isS9W5H?=
 =?us-ascii?Q?HyIVQumqKrBlkJaDEoWpbSHDIqpIHv/6rb7MqGcKZ4dVa2uowd6bd7G5vc2J?=
 =?us-ascii?Q?ql85g+yMnQXIod/rF6d9ALtEqth6zLcCEqB2rWRwl9cftv4+EoRV/qIPXGAM?=
 =?us-ascii?Q?rfslQ2UMpG8iFP9YLlI/A3JS1aA8tPJo70L06GqWm3P7wm9xJCVMPmHbNrAp?=
 =?us-ascii?Q?wdIFqGMVeHuFbdmo3nDxq9eYe04osZnTNetCXU5nDKO9/Imei3vEgnY/vv62?=
 =?us-ascii?Q?IqfOKHB3wkqEa9nRsYMt6xAMYJ8BYXytdVct8dIfAsrdgcKoezX1XDNTKTGz?=
 =?us-ascii?Q?cxufw3nlNHLSUngs1ILhH5QsmAr7rUVbOycJR10TrwQTGIn0Y4oEwpfw+gFs?=
 =?us-ascii?Q?b9nqCXhgpV4nF/AnnYabzw3fmshuXA8e2UNgHfqcfef6z/Je314/Ap1oFb3C?=
 =?us-ascii?Q?IkAjADEZtqZN47M68OTfAfD95qPqKLW7Rqf+mnAT91UKBBYv28FT6TBUSKE6?=
 =?us-ascii?Q?LBqkU3zr4cEvPNdxOPmJrW+pfGUi3zDDIF6M5K4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b782ab05-5f7d-49ee-9223-08dde0018dfb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:52:23.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB7LmvbQp5Abd/eN4MVtjAUvTrHvECoQkbpG+nrHjzmnSnVj5wCFAzl4tVkdW9D/X3u2OvMsGMGwHcDbGcyQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

On Tue, Aug 19, 2025 at 09:57:14AM +0200, Peter Zijlstra wrote:
> On Sat, Aug 09, 2025 at 02:47:52PM -0400, Joel Fernandes wrote:
> 
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >  	 * The fair server (sole dl_server) does not account for real-time
> >  	 * workload because it is running fair work.
> >  	 */
> > -	if (dl_se == &rq->fair_server)
> > +	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
> >  		return;
> 
> Does that want to be: if (dl_se->dl_server) ?

Makes sense to me.

I just tested it (even added a WARN_ON() to be 100% sure the check is
equivalent), and everything seems to work as expected.

Thanks!
-Andrea
