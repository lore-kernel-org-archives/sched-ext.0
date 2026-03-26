Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FC21CC4F;
	Thu, 26 Mar 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556042; cv=none; b=LwK+TErHY6yATJuoynHIb19KsdrbWzhUC22AfIUYnHrqIwSzCYKuowmWnq3vNJq6jpSeqw46Yw9bv6vrk6R9MIKG67nOtlo3gl+OxQL3UZdqk4pj83NnYYZXBapWuiBqPjLvra1dKv2XrgifXQ9BDN15diHcSXnyqTuhAW5w/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556042; c=relaxed/simple;
	bh=0ZS31D5osySqoDv07J8Vph9p3GDue+U68vh37vMxJaQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BqqydSzmbYMm/sdqkEezCBBfwmxlzldFS0Gb34AHv5T5LnBB5UymStz9GmTEaUUcoFACp+uuVtXC6hpF8qviRXAb/PMobdDw7Wh7uPy8zmKg0abzo7ufN4XEm4lhew819xDKhGB0+id1WLxnTlYgsGHKh4j7b1JOP2ChiVjkI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBX1TY6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBX1TY6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BF7C116C6;
	Thu, 26 Mar 2026 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556041;
	bh=0ZS31D5osySqoDv07J8Vph9p3GDue+U68vh37vMxJaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBX1TY6zMJQdfSvQlZ+rFaJxpJx6I44T3gxSjVXvYa3VgncWQCm8bMjZ4EacJNIS+
	 KD3D0rseEs49weqHdVDa2X9rt9OTvxvgURN5qtgHI3BDRoA8dr4Gbt1Z4oo2vT6GcP
	 oXP0bULeh1+rNhOXY6s1xIuEf8XpCQuABSwu/gYitQmomQemvhp4WaNgCzlrnVrvHi
	 Lw0IinB7oUa0NkuzxKdWQT0LBcPNbuGHQpKyyK31CjHewaVHAMDolwnkvgITsUS/r+
	 y8gMGflHPwARzVMFGWNTxVOG/V/DOTTBVTCYVTDeNS0F4N97E0QSv/05jEl2u962lp
	 7dIHCgoH8yyFw==
Date: Thu, 26 Mar 2026 10:14:00 -1000
Message-ID: <3479d70866051b8a1d83b47d7c5ccfa2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn, emil@etsalapatis.com
Subject: Re: [PATCH] tools/sched_ext: avoid redefining SCX_ENQ_IMMED
In-Reply-To: <20260326100313.338388-1-zhaomzhao@126.com>
References: <20260326100313.338388-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The compat fallback isn't necessary anymore as the autogen definition
through const volatile __weak already resolves to 0 on older kernels.
I just removed it instead.

Thanks.

--
tejun
