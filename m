Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB041A51B;
	Wed,  2 Sep 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390337; cv=none; b=fYL43KcXms2/kJJ38UB1EqKCdQLjbjmxlji8E4eAp6GLBcmrxslSlF7rbIEKeYww07p3J8yopUmPVxBuK++k9mvIRzofgZrGiVAY2LQehZucFojEBRr3ZWqj2nSnxEl1snCFj2xkUlS9VTNYHlv4trAh8JYszxLEm4FemXnonbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390337; c=relaxed/simple;
	bh=D6KMY2g2zcKbEiBS1nKLMSLHLrisu+berfL5R6QxpRw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UXfwd4zR7azxKrtkFoBhJrvsB1PHLBcj4sZtc7aZVJCFbesGu1GACEXGH8tpRdtqgYy2q95dqPtlxs2h4n0kl87peBSZvMf441bdUk9OyZjKQ4SCA18i2dFrPhm2jKxBwpvU7wixeJ720LrS51v4bF4Kj0OM9t2q/fZ4D6MmS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHFAHrsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHFAHrsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27DC1F000E9;
	Wed,  2 Sep 2026 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788390336;
	bh=x2Z82lyv/IbbVsxX6nav6X1cIH/2DNonabUZBqJ0Pm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XHFAHrsdqjuH8LwGgcMY0ywWlRquTQYPB899m7R+M9nmRWuIAqu7n4GLn3VmBhCgy
	 ovPR1c+nHmealnDyKS5WjQTbYV1ohrIDe35OrLpADoaamAKl038+upYCfYYrRpdB7d
	 KztVoC565X6JeN9G4b5yeBiGEJZvOdJ8K3h1ohItK61pZwob2DOgY+s/Mhd6a1A+qP
	 kORfcwVO7gUutpkj0kyEpcgTGNh+UCU+Zhl15eB68FdsBodYDKQSo0x5TNRkGs4YcY
	 pAQLP9J2P4VcXdBZYZ9NGQDQaxkLGMiQemK+SjrQzysExUcbMkQqB1Sm1GYvaz6uUW
	 D4zgiJgrDetrQ==
Date: Wed, 02 Sep 2026 13:05:35 -1000
Message-ID: <27793d61e70c3d4df415729e1d150ad0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Vernet <void@manifault.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Reject NMI calls to lock-taking kfuncs
In-Reply-To: <20260902093611.52651-1-liwanwu@kylinos.cn>
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
 <20260902023124.1422942-1-liwanwu@kylinos.cn>
 <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
 <20260902093611.52651-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Sep 02, 2026 at 05:36:11PM +0800, Wanwu Li wrote:
> +#define scx_kf_allowed_ctx(sch)						\
> +({										\
> +	bool __allowed = true;							\

Applied to sched_ext/for-7.4 with the following changes:

- "No need to wrap" in my v2 reply was about the line wrap of the function
  signature. Restored the inline function + macro wrapper form:

    static __always_inline bool __scx_kf_allowed_ctx(struct scx_sched *sch, const char *who)
    {
    	if (unlikely(in_nmi())) {
    		scx_error(sch, "%s called from NMI", who);
    		return false;
    	}
    	return true;
    }

    #define scx_kf_allowed_ctx(sch)	__scx_kf_allowed_ctx((sch), __func__)

- struct_ops don't run in task context (e.g. ops.tick() runs from the tick
  interrupt). They just never run in NMI. Updated the last paragraph of the
  description accordingly.

Thanks.

--
tejun
