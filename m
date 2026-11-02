Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637246;
	b=MM5geuynjdxY5BOJfYQwaqXNLdksd4O6KmtMKb0+D3hq+7OUGyy/GQGm7fOPD5EEwsGO
	 U/JdW9N8SrAGhj72AkMni6XdcD99fnmQv/GjBBhuHNrgpPFhacs8zZcEbbBioVCSC/fEw
	 zzydktCnq+3NjgVlGXp14KyRZuu6MT8lBa9mqWO6YLh1AyqfhCmpG3OnSN+uDqQKQ2Zfg
	 DeN492X0VkRfo3Ao8B6cLpBFob0hvVMKv+aMk5TdU2Iowa9Dh9kd4/0cLpMiE38IkugkB
	 zRlGeDEdFcDjTiKxY1QvZbQDnhqu+Z2/SxJkA8Bh5kWZtjwPogY224TjPZ37nWzMqnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637246;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QP+HE6vmuzGLbe3HdR/8wzLb/M7lRFFGRjYTgGG20kA=;
	b=K2g2ChlKIk7JJ5NJGMICQgPVtfH8TprAecGq4UxHhWr+03P7BR6KI4kt0SmDL3OHKenA
	 l6copY6Vn/IRlK301JU8hEyNXCS+0euSdCPQxobxjdxFi4CctpKyym6MPGDimKHCv7n9B
	 oagxgz5sYRZTIYxzoUNaR2LSidgQK/Jcx4iSvTGYoNYjvoqhEf7KHRjnCwQ2Jw+vpAen3
	 KoUnKAbRrQxVWOl9ast+4C1YTM/Aj5/S6/IP/tx+2f9patzl/IS9Sj5nK9rvCLYT9K3CY
	 K7o6mIi5pwtHRHOGZorD1U207oKPWP2vA0dyAu9RrQI5YljzEHMV6GMgJLHXyrRaeRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQev4lNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F36608B07C;
	Mon,  2 Nov 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQev4lNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931321F00A1C;
	Mon,  2 Nov 2026 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637245;
	bh=QP+HE6vmuzGLbe3HdR/8wzLb/M7lRFFGRjYTgGG20kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IQev4lNV0p4G4ZptoppRo2Q/gZwmkpt8LEC4RLvTMZNGmw5vELK/GSPheNegky6Yl
	 Y4zkTWThFljgaaarnGRhJQUgaeVoC6C9JKb5btk6mfE6kiR5aDbc3/CswNBxmp8Okr
	 6V7Lrw9yBySpn+0q3N+QHMVbd2Vbg5uwG5wybrueAVf4JRH6wyiSAyhx9235nAlNSr
	 tbF3Q3IippVT8t5TKOS5ri2MaoLWbCgUzzyK6e/F/fFrGFJghJWs2swXAe3JCQ55eN
	 wPM3jqO84aLfyWNRfgSXz5hy/oXgwgJsfXL7Mw3oYSWsdlDxAqeBG73+b89qgs8JE6
	 V3FmZ2iYtAMGg==
Date: Mon, 02 Nov 2026 06:34:04 -1000
Message-ID: <0c5a32d85c3bf4d9fa3bacafa510b51f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Luca Abeni <luca.abeni@santannapisa.it>, Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: sched/deadline: total_bw leak when a task leaves SCHED_DEADLINE while not queued
In-Reply-To: <auhw3ctxwy8qeOvs@jlelli-thinkpadt14gen4.remote.csb>
References: <2b5fb3f22bca6aa383be8f4781923392@kernel.org> <auRh42kZI1xLIWNr@jlelli-thinkpadt14gen4.remote.csb> <1a24bcdde0bb6e4a8c839351002e841d@kernel.org> <auhhGAjRtuSb5JP7@jlelli-thinkpadt14gen4.remote.csb> <auhw3ctxwy8qeOvs@jlelli-thinkpadt14gen4.remote.csb>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Juri.

On Mon, Nov 02, 2026 at 12:15:41PM +0100, Juri Lelli wrote:
> Would you be able to re-test with the patches at
>
> https://github.com/jlelli/linux.git fix/dl-total-bw-leak

On 473adf013e43, all three are fixed.

Tested-by: Tejun Heo <tj@kernel.org>

> BTW, it looks like I could verify with reproducers I pushed to
> https://github.com/jlelli/sched-deadline-tests/commits/fix/dl-total-bw-leak-reproducer
> but I'm not sure if they are similar/equivalent to what you have at your
> end.

They cover the same cases as mine.

Thanks.

--
tejun
