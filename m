Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED139CD1B;
	Sat,  5 Sep 2026 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788647111; cv=none; b=RlIwZkffd1PyYaPl44Pxv+BcSZOEaQjwOKLBsytyHaKURE0VCQIHGcqPY+fratN2mE+y6ns0PAHKcGoqFm9H6g+uiHo5hI/qGQ2xq/PBPPAt/njHOLoEoZZWZk6CJKngsyGzKgJBDwkFLIT7nUT6HaHmnZP/KxC6y4dvfOp9tFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788647111; c=relaxed/simple;
	bh=Rp+4C1agaL7JjVmax93On97Hgl0AUtV1wmLqW/Q5eBY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ckDIk9JRMrVcqWrFTELTwUAIurD50B1UK7O3d41uyjSWr/jjhUXUY+BYSo2U6Zl6zi+jrXHskQ5TeIRXqc7HvABP74vWtA79rC9zaygrRPUMY7DHKX1wrjQNGNef02/ox1AL83pAKWVm8XnJHsqjbjGctaMywvA42ELvK4XHnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e38MLNkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e38MLNkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F5A1F00A3D;
	Sat,  5 Sep 2026 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788647109;
	bh=uss3QYXK9goYm21mLWtRFS0WyQhGoGx4qbi8fOnzeRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e38MLNkWzwliRdQ8I3mi0iEbDlFhO9zD7bvH26ZwV0C/1aIoXayOtTSqqd7Y9l3q9
	 RjCoh4yGeSg1y/iq1vk7hgmAXxMEEggble7dHoDBls6dkE2rhHw9bAnW3A+yKaHv7+
	 UZV3iVNswKviD5vqDf0d+iTRmYQ23VuULFXNI2QXHGxOhZj8K6LMfCt8zwMxx/rwlh
	 JDNvz5BXUUtyjqP8dDbLFttLOiX+N+wTH/7vlsiYTkDRazpPtDoEjIjaazTXX2iapU
	 /oDJmFLvn/a0pgldm9xydtq57XWPSPlRN+NKO+9is1O6oKLom0w4LVMaOKAZAiyHat
	 P/gedskoKpQzQ==
Date: Sat, 05 Sep 2026 12:25:08 -1000
Message-ID: <1dae151ab83d3d2a75e33a7c7ee152a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 sashiko-bot@kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix keep-last for
 sub-scheduler tasks and two scx_qmap placement loops
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (4):
>   sched_ext: Rename sch to root_sch in dispatch_one()
>   sched_ext: Use @prev's scheduler for the keep decisions in dispatch_one()
>   sched_ext: scx_qmap: Do not add IMMED to rescue inserts
>   sched_ext: scx_qmap: Place only on cids whose caps are in effect

Applied 1-4 to sched_ext/for-7.3-fixes with Andrea's Reviewed-by tags.

Thanks.
-- 
tejun
