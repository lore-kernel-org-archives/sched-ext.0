Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C71DD9AC
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126466; cv=none; b=AwAXNAPWYUF1pXSU/0Ak0BBizZegg8FVQ+QIqfZblHYwpkJFro9kU8zDzQd5UAuOFzyy63N/fMqvjq/01hDA4SlkfF0KDJfw+8GWvlNTJFubaF1v5p95ifPWULav8To8X0RkRZI35MAUUizvT1hTjeWAfAf1iwkejjrDmt5HpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126466; c=relaxed/simple;
	bh=QBeQa65ZQfksVmHrCzO2PAMp8By/Q3N4eJ3Z6skNviE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Tla4vVc/oqQyoLO/bwJY+dvisytTfGMKy8ONWG96wJ1bzZgew88EDf2pf/nSqVY5XNv3W8UGcdukWlPxV7IijoLdJoXSCu/IKRAL3xb5s6hPuk/YjbjMi/v5VPOE4aJmVJubLulNFFfPE9/6ia4Jq3QZL9pE4wz4ofSjFEvytfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE1058PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE1058PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9042C1F00A3D;
	Sat,  4 Jul 2026 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126465;
	bh=QBeQa65ZQfksVmHrCzO2PAMp8By/Q3N4eJ3Z6skNviE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PE1058PShUtvHiF4L+Cnvqu72TnNl3rOd+NboOilt50vyVvAwmAcFY3Ccom4M4GZF
	 NGDYY7i4YysEHN00UHtNh10g/jWx7WFcY4EW8CVqWu82eEF+V+mp6FTAkZEveqxJty
	 FKGeryI2k2+IH0wk2mfYc1FwCEUTTPVWLae0ic9ZH6zvvaSlYfwv7PAiYGPzGWq4zJ
	 A5JPrmX3BW527Y9q+Lv42coezDnW1G2+cv1EnMWQmvNN5L9kAyu5Na3LGz3tAle2Aa
	 XIaKaY8OQqW0TEZAGrJyZehM+Ztpsmz+E24SCh0yDtvcYF4BRb7s66B+xkq527kdVY
	 KnqH9PNS6l5cw==
Date: Fri, 03 Jul 2026 14:54:24 -1000
Message-ID: <dec8121cbda9fd54ec2b1ed029995402@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 07/32] sched_ext: Make the kick machinery per-sched
In-Reply-To: <20260703090252.E95991F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-8-tj@kernel.org> <20260703090252.E95991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] List corruption in `scx_kick_cpu()` and `kick_cpus_irq_workfn()`
> due to NMI context concurrency.

scx_bpf_kick_cpu() isn't expected to be called from NMI context, but v2
will add an in_nmi() guard that triggers scx_error() rather than touch
the list.

Thanks.
