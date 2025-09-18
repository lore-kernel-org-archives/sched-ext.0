Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0734BA3C
	for <sched-ext@lists.linux.dev>; Thu, 18 Sep 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222183; cv=fail; b=nTKXNpEFVeXirpELghSHeuTv6fU3Zzs9DHjCdbqOIZXyg6bDUlON2+KPRxVXTIw8ocQOytISGvCAZckMnQUi6IIP6eHi9yCTUbeaC66dib5zpxrfQRKLivtQDhQNlUcDm+Vr5DQRhyqEAVPIogUUXz+rH0EfV9EkgPWuqpNWIEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222183; c=relaxed/simple;
	bh=VnCNNyyYjRtv/rCAGznlvQ7ArD1L8rvADjX21SkwyYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eoT9xmuoNvuWum1fcnxqHo9TH1YR6tELYISQNPZK84+evEs3v7ii+BSd1IKopbrwflsEnERJownM/2+aZ9t9j+HwDeWO+7Awpw1YTKcjOTmtBzMit5plCpxTs8T8fhhGHs7tLn/9HTjslPn/ISRSYU6HmzLlrYLl+GwbZFtkrhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=exmwFH77; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="exmwFH77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMHsRrbV74zn1D+DhvRAKaeO02X/Ro0B7nw2uqoNi9Zv6EtNbhXu6m/M0JxFgt3tZuFUn7IAJZTkFAJU/5/FWsjrkjbfB6HEJz08/mhspwswtVacS/DBWO3b0tgMYDCsz1e6E1c3E5GivSHOpo9QZc4TEE0Oj2S5CejfdLgHeRTlBD0dzeDWYwz/iH1nzHr2X92+xUPvSqYo3BV8+eTpZ1cCK0JBByGfpmn7Oy/tEKwwXZd++FJgP6FvdUfyAqjLo3IbkYU9B6UOk/JBycm4c0ojTqKC8hTYRBGrjKljzHKf7XqVk91UQ+szy4/0Tq+6PDNMmjhyGzPWub9MzUGUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEcuv+XDy7/hET3myIMfpdjcxotlOan4GELnUKtIBQU=;
 b=XyEGcL/0Wn4bswHFW/NFYBPMlfNgrYQFBaXhCYZiExC4CScDGzREykZevvunGEyj5a3qjq78DQom89nt+gy49YG+eqX2AWT7puPsUC/BrexV4cu3oXukOmiBd3Ub7jeK+Ip0ig2CXtLE6+MIfPEd/BEPD1lUXxhclLcARaoTaHD55acPsfWE/XQoE7ZlW7WQWPL6EjjZE0+4TIYCJJpf46DRrsY5Tq5HGmiH/TrOQ3PVz6Ttptn5nD0v4wDaoso9sTXBFmVWqobFlYJCz+9Mr2tGMooJrRK3qsPkKcs7vN/9677xTunBQkgxHanVLOqQBQ/JW/eM0YWdF7CopiZy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEcuv+XDy7/hET3myIMfpdjcxotlOan4GELnUKtIBQU=;
 b=exmwFH77mA5gH4rmIMLuFLp21H29/7HT66gz5CrQ9Ok227nAIgpK6SKnepUCPXGuV37u2QO79xxtuBnqhM1LoLXqIY1t9eu6xyI2t7s9PVN7JUyW8Q+YXND+/z5z3+aC0txnNe86YzgVfJla8OZ4KU1jjB+AM2br0tJERkYxwU2weX9yN2cyBunkY64HJOUFxrVLQsn5QT1a5t1iLPXnfWRFGa5p5ZRrfW7LU2q4O+xCeSeiqpk9NQAmws1U3WyOh8xnofbIx6EQ4Z3v8qSprZwE2Gq3xVT9zi5wKSLan98pzl5NDxVOurCd3+e8RwOXOyV2YGLOIzeYXD3Aj/EDCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 19:02:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:02:58 +0000
Date: Thu, 18 Sep 2025 21:02:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.18] sched_ext: Add migration-disabled
 counter to error state dump
Message-ID: <aMxXUwulcGrLdTFl@gpd4>
References: <20250918170602.2441024-1-arighi@nvidia.com>
 <aMxWAhJlE2Ah-f8t@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxWAhJlE2Ah-f8t@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f56eba5-9b7e-4674-58b0-08ddf6e5fb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYCyYKU2yt4Pr964d5pXKF8e40Q4qpjqFjL1Z9DJ3lEAzqh1rNNajX87xS1q?=
 =?us-ascii?Q?niVcOvrUPArQkObsT1ZjSMkrGWZE3qTfcGhZRoGgd78wKlBFy72DGdNsXIyq?=
 =?us-ascii?Q?Rx4ywr2XNxzPmGJGBKQhsjCLrlYaYsV4TAKHtb7ndFoQzO8A+FaPNQLijH8d?=
 =?us-ascii?Q?hzpX8dJGZUwLtyMYgn/6eI5NUaxgGbmcAjJmkPGGoLLN1wVwt4mr1Urbsw0w?=
 =?us-ascii?Q?KBP/Lod7gnFNdpZ7tWB3+uzjBVLdnqqKOEdyRQRE4qOIyGzVZHC4br+VktUZ?=
 =?us-ascii?Q?Ff6TgOdMLpAY5rXEAfOCxci9/Cb6goCzf/uVuDgerQeRIY1vC+4WzKlRs/rB?=
 =?us-ascii?Q?YB6VlAEilw2H/lH42S/2kMuoF3SGRPaL7uhcKzCgxGbmZ93q0O6vg0XGQEU0?=
 =?us-ascii?Q?sGRDYJwD6eKICODMdPicyuJ5W2RgCjP4Z8oq3itPzrDYCEKAzNAeBr9AoSrT?=
 =?us-ascii?Q?8ue3WUkUqfg6mZJ1DlRPxzakqPw8bO0IauX7LmK1rtlXLVk9Hf2ixeu3rcPm?=
 =?us-ascii?Q?e55vSj1OdtDY0zLrMflk3na6NdE7o5M7nTJ7lnzTn6Vn0cQeg+qd48CMmXBx?=
 =?us-ascii?Q?kM5uo+d0mJuoEudyqbDYSjWROzHhvJr6xAJYCZhWpDwH4Q9nVAnnoa6Ubies?=
 =?us-ascii?Q?HtMM4vxG54LqHtpSbNjoWALjuvxsBBVfQekxG/UqGtCb8z0PgvbP6kfbqday?=
 =?us-ascii?Q?ybNmr8OBpvnEWbh94iqrPi8if5DL2LN/M9rz9AeyT7DQZya4IvUpDDkgrU8J?=
 =?us-ascii?Q?ltenPwkAR2tuzSS0HAFcUJevDATOWqAtrSkm0o4HwPcIUUObOArl3eNmSuSM?=
 =?us-ascii?Q?f+YMKrqBlZsaSyYeX1he4D2Nvf2+U/sWuTOMs4l5pJ1/9a1ZxAp10v1QAFUh?=
 =?us-ascii?Q?C732dYlugz5HzqzM33tdBNjkPrQI8q9K108SNnUhTKQUfKezrYXC5MxMpN4J?=
 =?us-ascii?Q?ZbNyY55vUDjwDpdAU/dcDm5219TldGh49aEPlC6bPHIlIF+aRAXznC5YAHY4?=
 =?us-ascii?Q?H7P8HwWfumOYoY662PKZfH8zKWAGQ75bhbR5b5LZyOWiaCeSyeGVLaMDQcVW?=
 =?us-ascii?Q?OGvDuDthmyRu45ERJaSs+OxfCcCsre/EQt+xEMfQCrt6M/zP2kUnPopfZ1FF?=
 =?us-ascii?Q?t1jTWT9h7cx4BVceQcJGRtu3WTovvIWgqozZ4BtpjR0uuWQ1vV1FQx2G7LY5?=
 =?us-ascii?Q?+NNMOf6+R+QwyJ+3oaabm8lFMhr3my8S8gvIpMPAHq5UeAyb3wQDDQL0POPj?=
 =?us-ascii?Q?KEQj0uV+VKqZCwo0nY38I+fHYZ/xlBQ/U2gM8EFTLsOWSlYgOtvrP6bOQUY2?=
 =?us-ascii?Q?mtyRXqo81g8XOGzNmImlP+Hu0ZMH9gE7uTYnktQ2ChdZ55erkZYykZ8Hg0R9?=
 =?us-ascii?Q?MbSAHCHv2N+S7mCa7fQJ/s3vqioKnmYJkdwBZyJ3HrvnJA9Qdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nLPuPjI+v97yY0sb24g8zbZd6G+jMqaS4XfemhVNRzplvfHYDKSTpcm/SRy?=
 =?us-ascii?Q?UY0RTH7bHHYOxbpJGfyHAbRrtElY4M65TYnGFTxqOMP/2RvuboqFq0H8azft?=
 =?us-ascii?Q?LtQIwLSliswGM8a+du2kA4GF/HP1lhtXoHFYiC45iL/ABtNu5prRXmIesq//?=
 =?us-ascii?Q?58RB8eo8s2mnLH0c1kWhfkopF41rMin64BWr09jivKfBYHnfhKxLCu+8325W?=
 =?us-ascii?Q?el9tl39l1XJrTooKdfY8xexroLseHyW0Ar/qI2APT2o7zBRjD8eaNuqeBRkJ?=
 =?us-ascii?Q?vrWi2TFucXbOdaxFk+4N0aCXYRaxjMmLhrFQqcEfcklNFXeDf9XMIU+89sju?=
 =?us-ascii?Q?OxY5StzIRQceP9ZpTdQe7vbZk7/DlvA2E+yIcATeyscxoZMxrWlfYZMUMEFO?=
 =?us-ascii?Q?SWuxZJy8l6qmGPZ0+kjINfcXTUWoVOi+6Ykk/kOUyxETBLO7QCq4xWHrNeRZ?=
 =?us-ascii?Q?USs2OFcAIqWErjaWMVS/gqZVaagvNiXzM018C05d2Ik4uzY7+H5DvOjec/2J?=
 =?us-ascii?Q?maEPFaDirFrQfkiQCgx3ts78j5c9TgK9MYDaExsIV/CRqSaQ9kRCr2lrKErD?=
 =?us-ascii?Q?ycTZjim06+C9PORKU9kOkTSygDWeVekY9SQV9XZXd2AQkziFbt+rYDII0CUL?=
 =?us-ascii?Q?qb8MUjdf417id9wdh6H+AsZ/MhDqUXou6B1odOfY6JS1jDAzF0b7OHK3gUxn?=
 =?us-ascii?Q?m4uFPjx+DnH1PNNeXolLpS0/M7x1Yxj82c2eYumysoMyhZhulYOHHTT3KrmU?=
 =?us-ascii?Q?HHayzbTOQmtqfGEVLnouIC6quZK7/8HIJqVZH5vRED5dKLTMnXIYqM1BGT0D?=
 =?us-ascii?Q?ILt/cXRg+iGh4HD7veM5Emv4+Eluoplrd85eMUzpU0v290yLAYQkoSsu+XkD?=
 =?us-ascii?Q?6Uz7H/ejsqwNFXx82HTX/8Q75c58egR5DnLZlm3uF3I4ejACZ5/xRUqKcW7Z?=
 =?us-ascii?Q?22WJX+Z6wMoCN/qpLZlGCu0jQ4AXN49kUrp7VPVVfJrz5MlE8NaDsNWnZfGt?=
 =?us-ascii?Q?Ze5wv5DHXUtI8of/j0GetPLIt65aLQTrxBkRZ4xCm/6piBNrtWlviihuINGe?=
 =?us-ascii?Q?6dQiP7cKdULNSlL/Hcpy+bjP4asgH7MbUsnX1K/QZX2l7uTLaLQc0mLbefg2?=
 =?us-ascii?Q?R5cQPm6Cf2Vpmt0pWs9Ui/6B2FIcEgI2skkDB07XyXKuOihfzrJO11xIwNpn?=
 =?us-ascii?Q?WIpnDcrDC7wA8ZrS9xHjIH0R3OBw+oxO+sQ6D3ZiI7b2TK2XLBHOxkv1dV6W?=
 =?us-ascii?Q?Okkt2Vq50wGfuH+CezSJSPmvLNcL86/x9tTddVtFZFvCRKCYvrrn9CeExovO?=
 =?us-ascii?Q?Vh644cCYK6oB9/DwF0PcJJF7QwC2yZ5fok6FczMYfa9oKhULmQkmqnPEYLeG?=
 =?us-ascii?Q?xnydxVyFA4o4tIvOG7g37DAtD7V4Jy6CdC+gSUAR1UAyNQw/2uQ9+679e99k?=
 =?us-ascii?Q?gskoznIIVs2g6QWxzVcsX4avablmyRrKfktQXTQ+TgemgfdXOfQyDF64HDY9?=
 =?us-ascii?Q?Reafwvqjxw42exAV9gfHVGR2VTwOdVLpy/f4lf6KGzOIP+JSD3AL/7z5saV2?=
 =?us-ascii?Q?TwXeEEe9cnt3I2QV3TXIg2+YCK4OazvyKfYStv9S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56eba5-9b7e-4674-58b0-08ddf6e5fb36
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:02:58.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sFa9729kchEDPpZkPBdm8taEt1oHZJtmkGis4xKDop1XoAzpw+XCFNJECWQS2eHR1LtmArzgNOidmfldAio9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

On Thu, Sep 18, 2025 at 08:57:06AM -1000, Tejun Heo wrote:
> On Thu, Sep 18, 2025 at 07:06:02PM +0200, Andrea Righi wrote:
> > Include the task's migration-disabled counter when dumping task state
> > during an error exit.
> > 
> > This can help diagnose cases where tasks can get stuck, because they're
> > unable to migrate elsewhere.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> I did s/nomig/no_mig/ for a bit better readability and because other keys
> are using _ as word separators (e.g. dsq_id).

Ack, looks good to me.

Thanks!
-Andrea
