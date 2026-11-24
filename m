Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549923;
	b=DcjFZSgnaZi+ESFTwgaJvZd/IC8jeK1MGv+e8oFluQER5atXqavBdtZ4LuZQZfyn2C5q
	 O23HBeW7xvICDCPIK5w5b91bRt304kd/Ik3hq0riLKtNhwJmgR3UDnHKKmjOWd6m6Ai/C
	 bjSx7TNHjPUnNcBZ0nuQievVc2vkcDIuDOaxwYETMpM2BCG7bufo+hh+BIDSSSzNdClr9
	 6w6GNPrHBUpDT+Ie9Lr0NfRu9AOiu/6dIYCCkMQCa2Ux8LKl5Uv2Oxm48whtq3z3C0ExM
	 282Lbx8cWZT+gLOS1i7xZO8RWJOgSBbmpEBYsv75eY/qvBkDNHiiSYj/wiSPfva/8CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549923;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YsGDKuywNjy7eTvdHCBrAxn1NBt7ZHJ6uMlr90tWs2s=;
	b=v9r3LNuvT/2atk8oOQNkO6O08eGNEId9aYvR6AMvFmum/IKjCeRvZilJeW6LiFfGsO50
	 Tf40m2IZccPvv+2yjf8zRbqihDgbWvrLbgLfaIKO44R3rptPIEICnvk0XXlVdW7/bwDKN
	 taQYmzXwyD58IisecSDwpqN46iv57ADtYp3T+EfAZafk8Q4xN4UaLdaawtQzPar6+13KN
	 H+qnmIy0yhBPmPeCpwbOYnnSGqZ3aoHHFPzzsEWaua2uf/iNtMDU68QIWnmAqmI76EvLB
	 FxbGw/w3LVKBeDy8quIsqYYGBkVVyasnhEPnNwMFz9RCJkL6MtbW3V6T0oInSK0tASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XP70ESJc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B206606A331;
	Tue, 24 Nov 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XP70ESJc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C651F000E6;
	Tue, 24 Nov 2026 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549922;
	bh=YsGDKuywNjy7eTvdHCBrAxn1NBt7ZHJ6uMlr90tWs2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XP70ESJc3FKOOdPSYgRaCCVWdADEI9l546Zu4oRTHd14lBZN8OMhzzm4TL6QH5riC
	 bxgmIU819kdxVk9w8gNA4FmJnames/LAcAriMQsp03VDAWQ80JeVeiYtbZnVqtVBTS
	 7i10FmU+BNqihsjinIV9lv/VXh4X8McGl1yPXCRZxSPzKWsNvnQ772WLgUE76rQWDW
	 fHOBSdExFnUJwHGmJdEqRKCT1LKKJXIMWI3HXuNJoeQjwFdA4Q65aaC8nx8lNICWQD
	 V+5maKvIKqxMvv5wLJbSFEydDe8kDdQCvQ47CZxmW39TZsmbcOj8a7H94wsNsud1Sk
	 fBnjhryJ0bPYA==
Date: Tue, 24 Nov 2026 09:52:01 -1000
Message-ID: <7cbc63295439a7a0aefd345e042c3d11@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Don't allow unlocked kfuncs from ops.dump() and ops.init_cids()
In-Reply-To: <20261123135343.4131146-1-jpiecuch@google.com>
References: <20261123135343.4131146-1-jpiecuch@google.com>
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

> Kuba Piecuch (2):
>   sched_ext: Don't allow unlocked kfuncs from ops.dump() and
>     ops.init_cids()
>   selftests/sched_ext: Add unlocked_kfunc test

Applied 1-2 to sched_ext/for-7.4-fixes with the following tag added to 1/2:

  Cc: stable@vger.kernel.org # v7.3+

Thanks.

--
tejun
