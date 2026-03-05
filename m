Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179839E17A;
	Thu,  5 Mar 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727620; cv=none; b=HCUChjyboF7vAaNglRTrYoLNx2cp7WqTxd0pPuYprYiC+kiFo1dTSOzdNeC+b0KHC6LZE59HlbAhrIHDp1BaCL3FspcmslFbm6kt7DD6clmO64L/tgdeU4Vqu8+alTqN/8r0CJgufrQMyLCzlid22CWh8r49/eLyw+qgXTuv/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727620; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ja1sFdjkVz+EQ8dcDXMWURTJTTzh509NPndNJg2VmreVVxJtYVu9uGfZZruN2XK5gcKEwRowBb/CjoL5/8S8PFhz2gScVKpepGLIL88HrqfA8hQ2jSFAS412Z1JP65esQk8djmklLrbRbRK8IVSqhx+MEhe1iSfzqct3KHVZUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7qxSuW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7qxSuW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2956C116C6;
	Thu,  5 Mar 2026 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727620;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f7qxSuW+Qz57gJ8ryLgjA/RLpxtFBoAarIteu51DiAmRnU5h1tlmmKsfhAyw+lnmV
	 mt/BZtld3arnnaAV60X5e8Q0rEiL+MCno52gfcq0VKncIoI/69WAcKygAUt7VMzN+k
	 47aeJBEBDiPX5QNTSS8RN9vYCOvwxQa2uY+UURnEUHr3fx2IdGgDjppsOJan+B+BW1
	 jjEh+ScwUaSaNgovBB+Ip3HlfsNYSh1vll5hLkYlGFA20lF1fFolZ5xjE8u1PS8noT
	 e+UQhnUs1ESkMlQUWr7bjDUy8g69Cmf+gcIBc4tSR0v6/+Mq3amG7k2kGw3uneNAl2
	 tRRnKXwBeZayw==
Date: Thu, 05 Mar 2026 06:20:18 -1000
Message-ID: <c8389c0616b9f6d35917019e699583a7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for lock-free reads of
 module param variables
In-Reply-To: <20260305061856.1796545-1-suzhidao@xiaomi.com>
References: <20260305061856.1796545-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
