Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2E46AF00;
	Fri, 10 Jul 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702092; cv=none; b=ax3ZaXqqKztaDsxup87c9NUBi+C7K+vMy7YiqKKJHmypUKioFUXKZ2liv9fGt2x5nUPbcGec4wTEoYZRSInSp+ILrdS9dqw4WnkXw9FZReUq8cjEvhgMpdv0BgtncMmd9QyoVjEo5jsT8zykI5mWSu8AnhMsigmtL5jGmQlNpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702092; c=relaxed/simple;
	bh=OktS9Mks5Wp9BHcC7V+oQMK7lSf/N1woR90OpDKw/oU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kcCb22dXGnAkaHKtFxY/MiLS6jaEiXrRdJ8nnBfapmqqdv+dnH67oZZZfjfpfvwwpQzy+oaAIeCQ3KiDlhFqH7TZQezl9rugAa9d7Yu/RPbGAg5lk7nBnGdRLl/kKnG6E9GJzQa+HICVQG/Y1J8ETzNTCbijZVwI1iZJ17QoZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMJ62hmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMJ62hmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF50E1F000E9;
	Fri, 10 Jul 2026 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702091;
	bh=5wzaZdYA0VlZ5dqWSi/7tohSjmlzqdpQboHIaZySoYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mMJ62hmTDr90tpQD67DiuT451pe7JcNHfifnWt1+CS5ycTtqubm3m/iM+4SHZHUa6
	 E1OPLU3SwNyc9lkRBFasJrExdzAeEgKORg9vNmxh2EGdlkbak4JYbusfG4jQeyggh+
	 133RWgrLJd8+NwsOBNdjoioYRGINTG1mGVYuxZ3YuWtgxn9O0gcKjfYSoieAY7C7c7
	 pXTIe/G1u1we6elXSSXqQuxjsNB0NvwpLWi/eHaK7mG61ZeLfHy8F+SvZcmnhqczA0
	 /IFaD/g7EMpgXXvUE57FjIVEda93xVMpbqYhtx+XvSI6ermx/sFQbjIdGY0RvSB3M0
	 ngTyC7TZK3B3w==
Date: Fri, 10 Jul 2026 06:48:09 -1000
Message-ID: <c7b5eb5eb7e1425a10d0ea0fcbac657a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: skip ops.set_weight() for disabled tasks
In-Reply-To: <20260710144342.3802587-1-jpiecuch@google.com>
References: <20260710144342.3802587-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2-fixes, thanks.

Added a Fixes: tag and stable Cc. The reversed set_weight()/disable()
ordering is a regression from the commit that moved ops.disable() ahead
of reweight_task_scx(), so it goes back to v6.19:

  Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
  Cc: stable@vger.kernel.org # v6.19+

Thanks.

--
tejun
