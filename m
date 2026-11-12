Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471117;
	b=KvRP4HK5nlRLb7+av90OPzcGZzjBZRR5F0sROH92fI1+Z5W3eXMJW+uMJ7ziiHeC1LDU
	 UNF3C9t9lga1wVPJpAZsPRbnrfJ0Z20WPmKCLoObIJpkEWbhC7O/Qlez/o+p92sk+Xtuu
	 t7iBSp6gnL79bFhzJh6ew/7O/VOCvJ/3NlV9Ml8618iyzY+TjWMrg257bch7ZzIcQvHct
	 wTXlMyM4JLBHhnnBVC0mWuW5dOylZRupM/riLX+gjQSJA7B6j9K7Hw4vddk8GRj4T1nSJ
	 p6FoNu4MMLngqHAUhd12HHgJlqY3fggINKlIG6XyyKKdasqTISyGTph02u5rG/7Sg9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471117;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 Content-Transfer-Encoding;
	bh=yRwejwn52j/pckFIXfpb6iPXXl8i/31yG967frHncGQ=;
	b=uyLvnRRfDNedCItfUXLMLSJK/XLocraxr97iv2+XPEubvFbm8f/FrABi0eSU+K0e+IgF
	 dkdQiYj+gyqqCVrC//ZvqIwYyBqcpDIcBm/GpXiSTB/EhTxgpZaIB28S8InzcVoonfIBy
	 fdJAiKlJlEBExnDjWvd3nFlrsrEik64JqppxGJ+MHoqaELyz4QS2mzIM3FjyYeADYwTtE
	 m4NO2SPgQSSy0Iwl4axSYwiehLXw2jkVrwsUuE0auO8/o77fIyFpJF/DjxjlQp9rW/BJJ
	 pLI6Ft/JcayOwPvFC9+4VZOm3MqQQk4kFuYzSe2o5b+5IOpU9G9uvjpe8MYx4RqOPpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Eop3zxX0;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92F606A321
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B92F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Eop3zxX0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794471117; x=1826007117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRwejwn52j/pckFIXfpb6iPXXl8i/31yG967frHncGQ=;
  b=Eop3zxX03l9RnQYMeBxTQelYygV5Tsez/u/Rer934FkD8eqkr65+A539
   KlAIohQfZFEGz8vZMTWPDnQNUNXaBr5KXE7I/zQF/Zr074EnJfbGySRnC
   j3UM4iK9qabTNowb8Bj9j2NP1v/KVNS+YwDSuYCD2Udg60jo8U+BVsz6d
   YcM+7xk8q8gF8qFvHWPDdt3qR9ljF7mX+SxVG2ZgyNRc3mFqFmSkIU+gg
   ynvrGnNjF9qWVdga6e9KgDKZDdRcgUdXPae4GYPWJ6lmq7M2epQDceinE
   HhE3zJpGyVSjdMFVs2rOeR8BXdIdtZm5HY0mha/wFDcbqLQH1F/3L8S/7
   A==;
X-CSE-ConnectionGUID: 88UP8YXmSku6Ng9uIsV3zw==
X-CSE-MsgGUID: BDVhN59CST2+sSodA55VWA==
X-IronPort-AV: E=Sophos;i="6.27,209,1787011200"; 
   d="scan'208";a="33570827"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:11:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:28378]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 57c27c56-a479-41ea-ac2a-2ef1fd33fc35; Thu, 12 Nov 2026 08:11:53 +0000 (UTC)
X-Farcaster-Flow-ID: 57c27c56-a479-41ea-ac2a-2ef1fd33fc35
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 08:11:53 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 12 Nov 2026
 08:11:49 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <tj@kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <void@manifault.com>, <arighi@nvidia.com>,
	<changwoo@igalia.com>, <skhan@linuxfoundation.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <cgroups@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<hborghor@amazon.de>, <fmubeen@amazon.de>, <dwmw@amazon.co.uk>,
	<karataev@amazon.com>, <sieberf@amazon.com>
Subject: Re: [PATCH v2 0/4] sched/fair: cpu.max.runtime and idle refill for CPU credits
Date: Thu, 12 Nov 2026 10:11:44 +0200
Message-ID: <20261112081144.38224-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e795d4feb4a4e7ca4cf24f3cde9e301b@kernel.org>
References: <e795d4feb4a4e7ca4cf24f3cde9e301b@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: 7bit

Hi Tejun,

Fair point. I am happy to focus on the fair patches for now.

v3, the two fair patches on their own with the bot findings fixed, is
on the list:

  https://lore.kernel.org/all/cover.1794398404.git.sieberf@amazon.com/

Thanks,
Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07

