Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E13EB801;
	Thu,  9 Jul 2026 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636130; cv=none; b=E3mwOvakgtBTZin4UNhKM/SZ17Pi9E7iJDxLQAGZ+yE6tPBYENYzhHk/kCaaArUj0bvQVJZIecsouXnZ5ZW34incaD2vnM5zFcrRG9uYLp5F2ud0Duz1HPgVHa494viftg4GnqFVnsiEX7JjjFIYi3WzOKfCD27SGp3VZExIxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636130; c=relaxed/simple;
	bh=Img+uqyueQSAEx2+zznCpFUm4RstPI5srBUhwoA04zs=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=LqoC4ZHg4kzI8ALqG021NoGzc4yemdS9zY0K9xkAK2eITElvaUixtJ9bVMwLzLrUBMSf0j0bFWFHzPtRTod7ooiK3pEPk0O8hHUi7vj3pOmj1aUiLDeFvGyVco/QY0ajvQn1h9gfDoWF3nPeLDZin2mpmn5v9sXpKidcBSBjMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHHzIos7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHHzIos7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F6D1F00A3D;
	Thu,  9 Jul 2026 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636127;
	bh=iDaYQAqj9gVA44Vv3rEFGqAdn+N4VVkvalWra0Rsmcg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WHHzIos7XfJpSTIZ/z1O8MVu3ZqT4RuQXYaut35jQBfvKrJS/tqigWguA7aT0MDIC
	 9nxv690PYznSMdb7OdCN6dKkjdjDPMsJILjXVkOohlYA7gSjdHLtMTosIAne6auSwR
	 EWIFW3Gmg66epxQaCQBS64ptNwARC+ugaG8jjXFZuzPiE4abw1tKUuGQE09kIpoZNE
	 Xn4Zv8RARxmXX+CKq1K7f9Pzf+01AQXa+w6Cct9fua6ARFtDNkDArxdeXNriIbSra7
	 qQvJReBbON4y5s+lZNsdyse6Nrc8n7Yy8+S2SkuJMXv5GJhUUN77VZqy+5VWvmL5SC
	 ciGJ+Wgp2ykCg==
Date: Thu, 09 Jul 2026 12:28:46 -1000
Message-ID: <efdc8c9fbb3eaff712c7495ac7f9d92d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708221110.ED3521F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-38-tj@kernel.org> <20260708221110.ED3521F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 37/40] sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:11:10 +0000, sashiko-bot@kernel.org wrote:
> - [High] Missing `__str` suffix on the `fmt` parameter in
> `scx_bpf_sub_kill_bstr()` allows out-of-bounds kernel memory read.

Same as the v2/v3 rounds - the fmt/data/data__sz triple follows the
established scx _bstr kfunc convention, fmt is always a rodata literal
from a privileged struct_ops program, and switching to __str would be a
tree-wide change for the whole _bstr family rather than something for
this patch:

  https://lore.kernel.org/r/90174d41528bb30ba43cb15bc448c2fb@kernel.org

Thanks.

-- 
tejun
