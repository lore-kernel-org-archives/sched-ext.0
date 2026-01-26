Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D82FE074
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445039; cv=fail; b=Nt+ZH2VObYFbcKig6fPxazMC/iEegXbri+FZ8JquaJU6HkH6ThhV+lcleTlaSvC/T4dRoLoLkyqpV39dkdEnwMDaQqiv8CSY//ktTYUeENksi0pdGZU7hby9v9OKq4sM3gwFWdVFaeERsq6AUPaL6GETNoul0gLsopTMBrGr8dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445039; c=relaxed/simple;
	bh=HtlYQeqUYFDfdIjwgAelJ7L+n1Wrkny/+4+Qs+4VP54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2PShiTU++GvIAT8WM6uTrvb8Qh3wzg+6dYoC2VAxJyv5VDL0vFh2fwC9vbQ05Eo3gsZTjIrvEf0WOKDuz4J4W7SvFm2QtNPl3VLkkiiaeakxVOnNUyCiuS+xeavV6yup5VMvxpNhSU4QKVEeqcvEXdFIpN4oLa5hcabbPTyAnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8wTA4bz reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8wTA4bz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfXpIhwTKN02psgZZrCJ4701/ZRI3/WKsW5Zpzpgrt/74BGBtlH98jPWpQ0SNXfK0y4LapskL5+nP+frJApXz3bq2RHK7cZMT9l9on0jDv2pn7cx+jfSuEiCN2uUdL+ux1UmQVLSksA/2X4JWUd1g2RG0lSf8CSsOXHUy5QgWkF+llcwEtISPs8LayfzGPNwNegu4SXMyF+Xe7MsAXxdgtex02GXvMMOphCR1syzKXkzYPJ7n5z4cAYl9a4KQ7U0g11zUnU9sX/Lfllv8U7IItr6ovTYAaEZDuMUHJnQpCYPOm+CAZyD6VaWs7PorjeIYHfazCnaGPeGNM3iCqaWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Laa6QoRfTlnM7J57wAeqxXUwAusDh8fokNhZ24Ulor0=;
 b=RrIuXrga1KqgzKH/EydYQkD5Sou9g/ZlF/WGdQDZ3n6w97xTeP+PmvTbkYxkVwY6Ghcw7bFYe6mCy9xtGifSJ62XWGZHp5LXD40nO2j4qLQT0HI+RDVrI0XfF2po4gBLOL0w/CVpCF2YbmMvS4os453ploV3Q06f7jTyi0V7JFmlW8bsAZcrmidIz9LaJrx/dfI45I8/bvf8nc70yi9TuOJOEUPhlDNqZiBW1yGUV5uzXp5fSfCaMzfRBJ8cnYMzUziMD3MMkugG+tT/xEXyEW6Zm738gynXy/vfx+lbJGfxurq0ueSB2kUeB1AhUCgoVo2HDL6jyohFl53hPVlPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Laa6QoRfTlnM7J57wAeqxXUwAusDh8fokNhZ24Ulor0=;
 b=X8wTA4bzYx1ybXA1NclGhRnm0K2sBDLZ+MHu9HGgjv/zQi0A8YfG14QdHSmnEIeTLGzySbQywRNwM+bLwtZd1DEV06wuAZqMorcj5teo+eJvgl268/5+mSTKnovhInkCGOm18XZRnHSpztm7ZUC9gjPVL+yug9jJbrxTi8KYnsidpOV9tNifiFQUfh4zsF0/WNoIil/eNGuEO2bWYl4eoSxm6IsDGPiGRo88V3k3PnKluO7Gh97hmdN3z3HNcJqP4fqJAQfSaLZipndP5oCaU3lI2EIRxirTRp29+6z02eLKIzXVFkeOlm1leQEGqMVqjFlpllHvPNpheLH29wPUDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:30:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 16:30:27 +0000
Date: Mon, 26 Jan 2026 17:30:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXeWnzI3ymUSm3Cu@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 66df381f-f81f-40aa-0f01-08de5cf8365a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?aO67hPHfNDAumirgkkq11noyQAki8dw5Nemb3h5Dn3QOsuDmWmPlhuU0c2?=
 =?iso-8859-1?Q?7QQmvqt+n6tJXJe0k1dApaS4IwW116n5M/Blhk08QFb0OVrrwhVaJEwPhx?=
 =?iso-8859-1?Q?7yvr+DmqGSu9uLFLRvNqKdxOgOSX76L8XP8QIPAZ+Q/ck0jTDHLbmuWF/N?=
 =?iso-8859-1?Q?8MxiVDMKMdOhbArtLWrf8Xpko8ob0PYtytvHN56HNAhqiLblL0a5rTNq9m?=
 =?iso-8859-1?Q?EwNaldIO5EkU07Sa4wg0l6VwAnCRKsFcsaWpFXQwkuJguOv6OA+tXy5Lmo?=
 =?iso-8859-1?Q?zIOvyz8k8HPGaS6dgMCggpc6lVQIH85M4jH35r7Asfqi6rEvC3FbfvV5lQ?=
 =?iso-8859-1?Q?g3zUTtGk3NrbGsevFtKWulJpXVBX6FOErQFKN/Y00xSwMfzIIemTKxR1Bv?=
 =?iso-8859-1?Q?KQDdS0OgfonzmSQJLftUZ5CG2pbbcKlTzfmlGSDiJ0Knofi+UGqLNWOjgv?=
 =?iso-8859-1?Q?dCENnmyGgPL4jIHAaMmWqVLhwrpJpRbrtgS3XhYGTAJHD1Yto1H2lC2Xp7?=
 =?iso-8859-1?Q?myig2krojk1Sszdy5t1raBxYqDa/J3dMI2HRzcQMQTCqTUdGN+CGQRJg7Y?=
 =?iso-8859-1?Q?5HXgeRAxZzO1tAZuwhGCGDhiMNsV1MwcfPtxSbGFOc3D/kbg6htfPLZKEc?=
 =?iso-8859-1?Q?TYcAjWiYvocC58W3Ju5eQVg2eBGzB9rkNXR1XW7J3iqNYgDQIyW0BHFYL/?=
 =?iso-8859-1?Q?KuPcmte/EL7eYqhVLhlMrVvcriDyJCuEQuMRkr4r4BF3qm4wmHnKUqSj4g?=
 =?iso-8859-1?Q?yc/Sw69i/9mLNlAoAcbtEbrEq1yQMWhwCqKU5I14LcDoXAuXqicJ7BNA78?=
 =?iso-8859-1?Q?KSJg2vdWj56QPVARjepM+1m+S2bPrEVaF9bpxb6pEMwsvbqrXt8GSfj2gy?=
 =?iso-8859-1?Q?jzA21N3zS4sDSPpBKCsm8BWksazhO+1HET0cOcpLpW8j27aDHeh4AhQ4aV?=
 =?iso-8859-1?Q?k34SU6Z6FJp8rymFFlrmG0OoXfBK51xweHUUDPvqY+PGpXq6Tv46zteaSq?=
 =?iso-8859-1?Q?4ZvQcqodX6vQ3pqN0HewanKSz1SZz+Zx/a64zdkW+HLiX/reWKNwbHdLHk?=
 =?iso-8859-1?Q?wlnRiUUbyRzG5MpUHvEL0MKbPvRxnN7SRB+LSKCVrfsTJv2eX6mfS8FKKc?=
 =?iso-8859-1?Q?o23sHtPlbeshkjjPiXsilqApEH91YHMMs9ZML9o2H/jeaKHSKHF27540/v?=
 =?iso-8859-1?Q?/kIP5y41GafJ/i5feCD/nFyBZ1U2o7aZhvwthTQ143T9ZViGfcxaW6+MzZ?=
 =?iso-8859-1?Q?bcrzFmcvWF4Zo47XVLXSr93pbmQWNUIhBMl0mdaKQ6eHZr1E87ksV6mKUj?=
 =?iso-8859-1?Q?zfdkZVD+GXXGYcXHUy493LXySr7NhSMqmbbRmITqJnsLxk0X7El3ptrDek?=
 =?iso-8859-1?Q?0KIVHSYjdd7htkXYeCm7ZCpPAwJhK6zTx08WzZNXFddXB9R4OzVKz/Lb3S?=
 =?iso-8859-1?Q?4vzzSj+m/xEY93/No7Zg5cUtA0FVdnpYys2xJbSkOVyQxxGKxIlN8GryQO?=
 =?iso-8859-1?Q?cXiLO65ACWlUgctNPuqDSA/hmXEVrOKQRw8irMUL3ED2ksfhpdNrYqeJ/4?=
 =?iso-8859-1?Q?mJdYJGGDDGgFmYFsVesO/r4/2egML7QBCuzkWWXHmP2elg10YLi1+nhX8D?=
 =?iso-8859-1?Q?S9YxgkzkdjVUbz7ixIzmy1p+qoTRnjMTzI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zMacqyMkj+U+riznhQ4nvvgD8DtftVUXMlRQwYykfKXS+/L5gyXK49RtfG?=
 =?iso-8859-1?Q?8bNgtY4db/VyoJHVN+WTCJGpJpz7xO9ljAEYsI0ESeCsj5UqBAsnc6g7J1?=
 =?iso-8859-1?Q?D32JSSd0KbQrNH/anneqAvXAaWbYnrxHMNh9LJZ8og0Wq4ORvRK6XA+TUd?=
 =?iso-8859-1?Q?Z11hY9qHVwEX5yU1PjUp3i3TfV3291MDxwhuZ4sQsJtMP05+FeJHmIs4be?=
 =?iso-8859-1?Q?ssl1TUMxVqIHOZ113tZeaJm5ax5IexSsLQOuFU/XfBk4hx3AgdeAbf868I?=
 =?iso-8859-1?Q?zyxB9np8yNojoKHlGRFpLJ26GXTr1Wkj/RMlvF00MviLKWyqOMXYmPClLe?=
 =?iso-8859-1?Q?+1sh0e6NDspO+78xxEr8DFqHa+yV1EwSKFL8PHhtNkwgqBxCWfiXFl9swc?=
 =?iso-8859-1?Q?yyPrBsvcAskiJ2PaW561XvKWg5+3MF2ERF7R7YD41F86ZPzZPuv5sbcWTe?=
 =?iso-8859-1?Q?rK/FA7BEI852Gtj0/lIrKXE7YoIzwmZdwG92dkHRH9axnmlVZC9eWJLbLN?=
 =?iso-8859-1?Q?aufMLciSYqbsoZD6ra4Iy93hXTgVR/dRAdCcWAf/8rVZc/FAmUBNiabQj2?=
 =?iso-8859-1?Q?7c5KYSWO6GxjsL5Q91oPpGZXb9AYKu92F7e2Cn95G2Uo0Z5JsXLwGsEqXR?=
 =?iso-8859-1?Q?JnG5VGJRU09SC8RBR3iDBhUSlTX1uMZEsDvNympr/xxc/InnDfWQO17Rk/?=
 =?iso-8859-1?Q?PmLWqXbMI+H5sJmAsxGilr7nn2VhuseeITnxwXuIP5zey7wkc0XOg1W4ux?=
 =?iso-8859-1?Q?RtA+a9LDVKxdZrECj4sr32Z7tmLc+hpNdNz7W7yjW/zqhM5IVGa6Ox9KR4?=
 =?iso-8859-1?Q?fItjbFDjeYtadpzlsvdx/5ApSYuMRNgpImWPAxllyJkB2Wkgb9nuhEsb6B?=
 =?iso-8859-1?Q?s/MbLfRC6IgpjKEl5zQoxKzBKbDV4mHXcImKbXuKyUaw5pLk1XfyJEuZWR?=
 =?iso-8859-1?Q?7+5xtMVE3rp2BZCsSMKpP3PuzjHfBBAkgim7lc4prWXRntoe0/UnxNVT3I?=
 =?iso-8859-1?Q?3bnh5ScZLUU87f3w7D1I0pXXP0FufNAL9gt/6dze24ZhMcMQoeIgs4sdmT?=
 =?iso-8859-1?Q?oJ6hFdhxcjjRs172hkwWAJGj6xzVMEKWZx8fCyLxLHGVF7P7ItEfCLYeb/?=
 =?iso-8859-1?Q?nme2psie/XiV48lZqT/iEk5VzgYz3d1bkY6sFznmB3vIMex+ZvU3JhkwuL?=
 =?iso-8859-1?Q?WReBV5c2f/IMk1qch8EqJ3S9mzl8FjHbjqbNn07BxSNfzwf5iq0bnbXYZx?=
 =?iso-8859-1?Q?DWwIC73rEdDH6jB5QH2rFqszu4oePQ8RxxtkAkHEp+ZUk2R541HVlTFGsO?=
 =?iso-8859-1?Q?CEomq8+i1eJhfgngKv0sXS+08lrxm+F5vmcgw83ddmdv2mIYd5sDYwm2+8?=
 =?iso-8859-1?Q?e2sObMX6QEqwOyoTruk66FrnUAxJ57jbbP4PnnC2hDWuG95sjpqaEbHzon?=
 =?iso-8859-1?Q?OvSQKsZVLqsjUJUA9gITktCSEGJf3DEzGM6smiWjfkHd850nc5Pc0bmh2e?=
 =?iso-8859-1?Q?z/drhyrO+mfS3mSi1j245xDXTlpdztCuu2boZVfddA4uWgAZSLl11zliAq?=
 =?iso-8859-1?Q?P/wV6ByAXwgPt5ZYpDDEFWWUN8+6MTk+tR89Hw9qmATqLRKUBPlBRvdv2J?=
 =?iso-8859-1?Q?QoTMh2WPNoMy8zKEqE1jjt1hDL+hUtfUP2uFyQ/vR2nnTR+E6yUhbxoson?=
 =?iso-8859-1?Q?znSPD2WS7UMrWZ6H9rg3Tbii3rJ0Mx9JRYN0Ia8pVioVOYchukKFHa/LZh?=
 =?iso-8859-1?Q?lDLUznfGO/wzRqPJsBbOO28kB0sLZyx3TvhCobjoQoimmS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df381f-f81f-40aa-0f01-08de5cf8365a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:30:26.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VQ+CeVTNiX7NRVNT57LJKUmRZWGM+y5lKnCDqn7iMh14iv8VSgpS5Fic5cwCEtz0ep/Jczdg17dVXgCj7xVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600

Hi Gabriele,

On Mon, Jan 26, 2026 at 03:20:12PM +0100, Gabriele Monaco wrote:
> On Fri, 2026-01-23 at 17:16 +0100, Andrea Righi wrote:
> > dl_server_stop() can leave a deadline server in an inconsistent internal
> > state across stop/start transitions, causing it to bypass its required
> > deferral phase when restarted. This breaks the scheduler invariant that
> > a restarted server must re-establish eligibility before being allowed to
> > execute.
> > 
> > When the server is stopped (e.g., because the associated task blocks),
> > it's expected to transition back to an inactive, initial state. However,
> > dl_server_stop() does not fully reset the execution state. As a result,
> > the server can be logically inactive while still appearing as if it was
> > still running.
> > 
> > When the server is restarted via dl_server_start(), the following
> > sequence occurs:
> >   1. dl_server_start() calls enqueue_dl_entity(ENQUEUE_WAKEUP),
> >   2. enqueue_dl_entity() calls update_dl_entity(),
> >   3. update_dl_entity() checks (!dl_se->dl_defer_running) to decide
> >      whether to arm the deferral mechanism,
> >   4. because dl_defer_running is stale, the check fails,
> >   5. dl_defer_armed and dl_throttled are not set,
> >   6. enqueue_dl_entity() skips start_dl_timer(), because
> >      dl_throttled == 0,
> >   7. the server is enqueued via __enqueue_dl_entity(),
> >   8. the scheduler picks the server to run,
> >   9. update_curr_dl_se() detects that the server has exhausted its
> >      runtime (or has negative runtime), as it wasn't properly
> >      replenished/deferred,
> >  10. the server is throttled (dl_throttled set to 1) and dequeued,
> >  11. the server repeatedly cycles through wakeup and throttling,
> >      effectively receiving no usable CPU bandwidth.
> 
> Hello,
> 
> I remember wondering why defer_running was kept after stop and Peter suggested
> it's to avoid penalising tasks with short sleeps. [1]

Correct, dl_defer_running was preserved across stop/start to avoid
penalizing very short sleeps. IIUC what Peter explained, this optimization
relies on the assumption that the server is stopped while its execution
context is still coherent (the remaining runtime is still usable and the
deadline has not yet expired), so that the server can resume execution
immediately instead of re-entering the full defer / zero-laxity path.

> 
> Clearing defer_running on stop is in fact removing the edge from A:init to
> D:running , isn't it? The server should be able to start as running and not only
> deferred (dl_defer_armed and dl_throttled set).

Yes, that's true in general and preserving the A:init -> D:running
transition is desirable for short sleeps. However, it's only valid as long
as the execution context is still coherent. In the failing case that I'm
experiencing, the server restarts with exhausted runtime and no
deferral/replenishment timer pending, so starting directly in D:running is
no longer a valid transition and breaks the state machine.

Maybe a way to preserve the short-sleep optimization without breaking the
state machine could be to retain dl_defer_running across stop/start only
when the execution context is still coherent (i.e., positive runtime and
deadline not expired). Otherwise clear it, so the server cleanly re-enters
the deferral/replenishment path.

> 
> In the sequence you described above, I wonder why the enqueue is never
> replenishing. As far as I understand the runtime should remain <= 0 only as long
> as the enqueue occurs before the deadline, after that it should simply replenish
> a new period (pushing deadline and restoring runtime).
> 
> What am I missing here?

Replenishment is not triggered directly by enqueueing, but by the
deferral/replenishment timer. In this case the timer is never armed: stale
dl_defer_running makes the enqueue path believe the server is already in
the running phase, which suppresses deferral arming, causing
start_dl_timer() to be skipped.

Thanks,
-Andrea

> 
> Thanks,
> Gabriele
> 
> [1] -
> https://lore.kernel.org/lkml/20251111111716.GL278048@noisy.programming.kicks-ass.net
> 
> > 
> > This results in starvation of the tasks serviced by the deadline server
> > in the presence of competing RT workloads.
> > 
> > This issue can be confirmed adding debugging traces, which show that the
> > server skips the deferral timer and is immediately throttled upon
> > execution with negative runtime:
> > 
> >  DEBUG: dl_server_start: dl_defer_running=1 active=0
> >  DEBUG: enqueue_dl_entity: flags=1 dl_throttled=0 dl_defer=1
> >  DEBUG: update_dl_entity: dl_defer_running=1
> >  DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=0
> >  ...
> >  DEBUG: update_curr_dl_se: THROTTLED runtime=-954758
> > 
> > Fix this by properly resetting dl_defer_running in dl_server_stop(),
> > ensuring the server correctly enters the defer phase upon restart.
> > 
> > This issue is quite difficult to observe when only the fair server
> > is present, as the required stop/start patterns are relatively rare.
> > However, it becomes easier to trigger with an additional deadline server
> > with more frequent server lifecycle transitions (such as a sched_ext
> > deadline server).
> > 
> > This change is a prerequisite for introducing a sched_ext deadline
> > server, as it ensures correct and predictable behavior across server
> > stop/start cycles.
> > 
> > Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> > Changes in v2:
> >  - Update state machine documentation
> >  - Link to v1:
> > https://lore.kernel.org/all/20260122140833.1655020-1-arighi@nvidia.com/
> > 
> >  kernel/sched/deadline.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index c509f2e7d69de..e42867061ea77 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1615,7 +1615,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64
> > delta_exec)
> >   *   dl_server_active = 0
> >   *   dl_throttled = 0
> >   *   dl_defer_armed = 0
> > - *   dl_defer_running = 0/1
> > + *   dl_defer_running = 0
> >   *   dl_defer_idle = 0
> >   *
> >   * [B] - zero_laxity-wait
> > @@ -1704,6 +1704,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64
> > delta_exec)
> >   *       hrtimer_try_to_cancel();
> >   *       dl_defer_armed = 0;
> >   *       dl_throttled = 0;
> > + *       dl_defer_running = 0;
> >   *       dl_server_active = 0;
> >   *       // [A]
> >   *   return p;
> > @@ -1813,6 +1814,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> >  	hrtimer_try_to_cancel(&dl_se->dl_timer);
> >  	dl_se->dl_defer_armed = 0;
> >  	dl_se->dl_throttled = 0;
> > +	dl_se->dl_defer_running = 0;
> >  	dl_se->dl_defer_idle = 0;
> >  	dl_se->dl_server_active = 0;
> >  }
> 
