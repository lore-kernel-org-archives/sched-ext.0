Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD583AEF43
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485966; cv=fail; b=Lim0w7VDlTH3vF0HT1wJjZhfpytUGfKuRtUBwxsPPM7s6HtDxszpYJqQdlnRU0o34Y+5F4N1A7lq/YsRT0OWJPIgT3FfpmSAw2IxoKrGp3itCeH4QW7RuBhlr325WRdHy+t+lfMFzuKSPhBQfTIxqd1lvBdpEjKzKy6Lzo97MLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485966; c=relaxed/simple;
	bh=t0X4+1mrn5jH2jC/tfkMrJMsG6sz3gS+zHj1n57dcOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEvkbjJ43VyLsfyBirwjdZV2wwcAJwdaNK7tyZm7UF3m58CvV15Wr/uTP/sBiVS7mgSmj+z51G+bM0eJHedwRUAAKkLlnovYnB2AoyAr8MRZLdgAYQf6bWrZrnhs6ToCd4G0G976o2VrCmPSYLCakJ3E/EX4Y8iYrCFV7G4sXwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rkaFbnpw; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rkaFbnpw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL+i1ZB3gxeh1tU9S2Yv5LZ3UKN3mrbBnwzYdrzF26p4dvy2CkacLGTQtErIvFrt2FAHpvLzgvxVXXkDP1SQLxIglu2oBSp9sQO2eujyaYap1yzDhwFfGqpC3FTKC7UGeiPeDyzJj1o8XyNRXy4llv+aygaUAwujHC5G+gIc+6+EQBYfMyhH6/sQxxvF1WzJG98AKyTWP5cLXy/qmybXQ45wVqaXrxlQp3dfJ03bUfH9U1O2zorYH1MQA/Mbn5OG5yokKu9GdkD9wyJlwfeonFfZs0WD+sRDJsNtJM38XGrUAs8F3z/ueLTrYbUVewA6YT+5NsIcB2HuRSGn6jhZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OoibthkHpipOOvy6S+8i4li7OO0a84SLslMfoU9RWQ=;
 b=nkh8ScVxlqYL5ZCK11tPAOuc0O+G63FMQ4yZ4S7kP1Rz+n8CG2zkAw2X4n8ebKYjJHLUM/Iitq49TjNY6jQM2ZVdlbiMGH6cvPi5VYX7Wdg+TG+ymamRimbnkOscqdpm+LhBXOeWiVoT9H7xnFV94pzmeRJlz3U3KEruSWSTec/0fWM0bJH640F+dSziG31pCgnzCX/EVzrmIP2tX1ZCiFgbHF1R2GyUfWsZ2UieeEgUdP8c6AXX+DgoY5wztd8MLvRkG8a4s54nL3RZGvhlp/VW3ZvwE8Rx4KIjLix0o3fZIcy8BgKQNH2KNd7KiUP2Ux55Fp9dyTEhN8PuRM1usQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OoibthkHpipOOvy6S+8i4li7OO0a84SLslMfoU9RWQ=;
 b=rkaFbnpwe0MbHbD5k9QdfEzOTtZOnb2RdooS+qU3qzav+I7PyClelRzdk4Tn23iDtljCoqiSZdrqWUp7aaZhPtIGLLRvqlzJ7J3COhWfL3BPRHogc/L4qDOWfFN6d6gCkc6fRV5FfPMHFOXv90ruceFq/om13HgLRX3Gn3M9PI4YUxf1vICEBHgq1PM+EUUhIZqM7ULlZD2BUHkrfHMqltr7xBQmsPDPZLbj3VoH0F+vrNuVZibSMyVyJuPpvPTIKrPfzG6exqneI0WVZsarBxpV7HTTMLzsVxJdgQenFRgaehdaJIq/+CkieE0JMVBiVkgCA515XKvoHpBRSClqeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:52:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:52:22 +0000
Date: Mon, 11 May 2026 09:52:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv
 clobber on concurrent attach/detach
Message-ID: <agGKravM1oHxiA-V@gpd4>
References: <20260511061812.2459458-1-arighi@nvidia.com>
 <0dd41fa159da749a1e3ea88cfdbcca17@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd41fa159da749a1e3ea88cfdbcca17@kernel.org>
X-ClientProxiedBy: ZR1PEPF000077F0.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::455) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 429def2f-fc69-45f5-bd3b-08deaf323c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OX8DFBuUStbMCLkOUnZ1I4ec7w0TVgxQDz6r8/c7sDfYhextne+2VKjDxPlSUAdBgx3atJw4h0cDJbtxHphXTzco45P0VFDPe8fR7P+4rv34TuXN4q551tEJPMZJyRyjfXEQxyh8U+N0GxWLqvp1jrJtqcUWZL6kdYAJr9DGD5JjBnYFgo0s9QoMMEWkKJ/9AxLFSf6TOxNS9+k2FmyJOVVg+NmmYMD2dm2NDyVsmUnnvdtxRnTkEmQOe6adIK0ezUToqL6tqPWiFtkku8qOa+ZgsWBAi3F4dZcygwQ0wXQ84FLcbe8ujZOl5snV8YfJU8J3CoFbA3SuWGIaE1N4rgtCUNL42mU5BWTb8alZh/dJy8rZlKSVjBR4+8hEQXYEbtMxtmMWerGrrkr7jE5PlJrSONdjH95okwIzP67FiqCbmzcOegrg80+CCdJ2wbVAU19DsiIMZPVcygRwN/DQegik+PhXFF1jE7SWs5KPwB2hisPsk5/1BQ4OJb7MkaD4sNy9LPIevo2csaBi1z9E9o0/OLio3m2yV6SOJABCNa5f7CZkoCGg/o1NKwd1nuGs97umHps82kAkoYlI3pVP+iH4kI5urIfUDj80LyTrgJgB/EOmV4EcZogUTfnPptm0LsoJv/rz4qaLSMNz8qtDG1mxfjAGBrsvgsApjsu/pddSIxClG0xN/4IPWMguJtPi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yhj3//P+bOjQbI4LPBgogw8Q0D7H2sLouZ+I98AzN8+oy1zRot4iIqcqksSt?=
 =?us-ascii?Q?2jKXXsgNDF5A9+hdCzQGbuw2Y2yHMZxRirtEMHEfFZhccKnOWbEmShYDFtH0?=
 =?us-ascii?Q?g7dcwsCK6Ls4J5caFbScnrfXR3YkrzgzQK6OfqAkc2gsaZUm9/peouPY/Dze?=
 =?us-ascii?Q?/hnRpRA+xLvnhfjp7K8pwiqtaixaCB0Ti161U+sjqGG0j45MZtcdDjUzMoC1?=
 =?us-ascii?Q?nVHDHKhC+VrA1LyRK8nDC4poj8l0ED0PBzXMElGKIJ+CDNQDdLroZN8JB9y1?=
 =?us-ascii?Q?pDlfQAQ3eM3oZubR8nU4GFSc5nGW/dSBTt2Nhy4w8+JcuaG53viIpWd0jcfQ?=
 =?us-ascii?Q?lYZh9M3Na7iYbhmsErAfmuI1bAf37pJC59EWhC/h3rLc7n9uMzVxw8FGVfJr?=
 =?us-ascii?Q?x8iPrMuCBKm+bOGTc9aYCNr1f9vI2pYtn7th7zv4n6Bep+r0r2Woh2u7mVTi?=
 =?us-ascii?Q?7IbMUDjHxbhYTxX1Iav7OYIMJjnFCU59zl+mGFeeIE7CigcQHE4RVhmMwsD1?=
 =?us-ascii?Q?mkNV2EtsP492W4gtKb9kUbRP5kHMJkuCyNOaFbpVMB80o+lTfMumB7uwTZZs?=
 =?us-ascii?Q?38CvNKEoJhu29kgGcxoiIcM7LseYYB+Y6FIivTM6yKNe/jeGQDOsrk9MK51O?=
 =?us-ascii?Q?q37qVGH4n3aJcligSe4YoKtrzPjv4TYGX29Il2qHKRtHFi1QAbKA0uzfmuDr?=
 =?us-ascii?Q?p5icRi4l3LpftbMBxx+qcaLukWQkyiCFaf3aoFfXtaVYqi+OK7iiR5HNCA5x?=
 =?us-ascii?Q?0/bFk2c+ZK+LZF5velmCRXr5rESn7MW63JyUxhCU511hG/s1iiC96kyV54G7?=
 =?us-ascii?Q?m7OhbEngrs6OHbH7eQdnL+k3tVH/VtM1INfw20fNmcXMN6pAceMdO+ZllAkk?=
 =?us-ascii?Q?fyqjfMbqOzdsT72bbQKzBULz2iHYWDW5zFSEq4MMPpFGHMlpZG8AQ2G3awII?=
 =?us-ascii?Q?c8pBY3qfyaeNoffMz5PnUxd0nkavitrMqmVOU6Vd8N7dRBFTZYZCpXuzHkWk?=
 =?us-ascii?Q?CVGzarqB99wkl/Sz+bVQQpq1g+Tww20WTqeZ8nkua5MyDGW/o7gckrANM2Y4?=
 =?us-ascii?Q?mcBS2TZ6oqKEkCz6cyCUTFyZpYkYnk9qKpERYgKrjyKbmwhscKopkE/2c9v3?=
 =?us-ascii?Q?gXGkXoedhpINPeYnRd6G18KcPmCdMTseOAQc6mnJFdOIB4nLy/bsdC+KZaCc?=
 =?us-ascii?Q?lYK8T7EXvedIHp7WLH2QXdh2lcbAiBv01wogM/9JF+nSxeEx4gvjyFj+dn1r?=
 =?us-ascii?Q?5jSHr55rLCEwwhIseV8rUEsY5Z4pxwGuQ1Rups1KC839UrecNdhlbJ4S42h5?=
 =?us-ascii?Q?M93B7Vo2ETMRJLcuXNCeWXbRCz+ZBKUM1Xv7Q5yLTERGM633oxM6+JQUxpRm?=
 =?us-ascii?Q?c0yfN5JUXstY3+r+98gitYZVgPr+0wMymAAnLtgsOCOGAUYLdd7NFvRiRa08?=
 =?us-ascii?Q?I0yeTqeeyeZRrn6Rd6wCyNWP8gXzQ8B5ZemgBMRN41ip0wxPArSo2vmAaOxg?=
 =?us-ascii?Q?9XXCVDV+CdpDR3/QbU/N6ytnf9npf1F6wwiMHCpNN/NVTJklytGR2aqCUH/0?=
 =?us-ascii?Q?wHwlWXJsH35mrRyBG67+AnNcooZ23mXw82gCmLS5Ntb2QFZm4enJGA8nAsP0?=
 =?us-ascii?Q?iXxIRDTV9AvajG0Bgn20/56RwZ+fStllxL7oTsbW369nmQUb2TOLMsKjrJNg?=
 =?us-ascii?Q?P3aPHpFbPdXdw7fZAq5o93EbYwPj7ESuDIDsEM3ymKMV5l3fsf9aiJ4CRg7k?=
 =?us-ascii?Q?UWT4Bnac7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429def2f-fc69-45f5-bd3b-08deaf323c1f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:52:22.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7880aCIkDUw2d3+9zy7vUQft46PbE3zi7IP/3uHhae/qSTPDJQBuB8wXs8E8oVay3X7MqSGIfRInmxF7+v5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

On Sun, May 10, 2026 at 09:47:52PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Applied to sched_ext/for-7.1-fixes.
> 
> One followup if you have cycles: scx_alloc_and_add_sched() can still
> fail after rcu_assign_pointer(ops->priv, sch) (sub-sched
> kzalloc/kstrdup and kobject paths). With the new gate, that would
> leave the kdata permanently -EBUSY. Could probably be addressed by
> clearing @ops->priv on those error paths.

Ah! Makes sense, I'll send a follow-up patch.

Thanks,
-Andrea
