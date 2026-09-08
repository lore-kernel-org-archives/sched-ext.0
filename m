Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3B58FD1B
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887401; cv=none; b=nkrShyfpLb5CZdfLzfIVeVbIWBR/eJaupTjW+FTKimkNB/htLwVencykOUxBZK+4MbhPg9lupK86oUxEbsGkiEUDFUD+FKDo52BO9S1PYoykRJcgcdOJu7cYN1VjkUwPIPZ9MIyA5/EGvb7HU0fDauyR8823TUvWmpqkIDQwnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887401; c=relaxed/simple;
	bh=uz5ixdGtsaDHtSWHqHEnEIAwl+NyH6e0taaB9UUwKG4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WKT/ns9lupqUp/YJ7ZOSw9PcvEUkbYXQshieEnUmRhFXt/spezLH3U5opaFpOyCGWL/kSzh9doDg+k6glf0kOHRmvSave2WdhM2WnPkMnhPG0M2aNB25N9KHjbK0L5seJA8OEZskup8eNY7UZfkaKAMRE5DOIfqT5NXJ1YxiVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn7Gs+Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn7Gs+Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6949F1F00A3A;
	Tue,  8 Sep 2026 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887399;
	bh=uz5ixdGtsaDHtSWHqHEnEIAwl+NyH6e0taaB9UUwKG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rn7Gs+Icf9r83JRUXbCSjF3QOrxhyS+P007e++iLfxGqrCptYnN9Nd9sEURzUoi3F
	 w3oLLg68hHEedg5372pObmOL//ObN8TEc+tRSnXT8EymQ7rUu3eq7CLV+R+9hbLwmH
	 3MzZCUlMoQervcZwAejpSsgA2A3vgs0c/KlUhPmX5uc+MiF48QWQvXN11ghpizEzPw
	 d7MxQxfAp4qANj2nZt9UUUcX32jASjSZ1tgxU2vgDOh3yNxMaE0CRRDrxjRfP1Y/XD
	 +dZeIimSfV1d6u0oCOPYdrAOFSidsIURhjQXQ0zZK66gCfHM5+Fqbi6slL47hWQ5/P
	 56YqYj7ih2CaQ==
Date: Tue, 08 Sep 2026 07:09:58 -1000
Message-ID: <69b6f95a0a592588389a45c36f47c4c2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: Move -rdynamic to LDFLAGS and
 append to it
In-Reply-To: <20260908134722.8671-3-yphbchou0911@gmail.com>
References: <20260908134722.8671-1-yphbchou0911@gmail.com>
 <20260908134722.8671-2-yphbchou0911@gmail.com>
 <20260908134722.8671-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Sep 08, 2026 at 09:47:09PM +0800, Cheng-Yang Chou wrote:
> Unlike the demo schedulers, the selftest runner requires -rdynamic at
> link time to populate .dynsym for testcases. Additionally, LDFLAGS uses
> '=' rather than '+=', silently discarding USERLDFLAGS from lib.mk.

The runner doesn't need -rdynamic. Testcases register through constructors
calling scx_test_register() and nothing in the selftests, tools/sched_ext or
libbpf looks up symbols dynamically or prints backtraces. The flag was copied
from the BPF selftests where the test_progs crash handler needs it for
backtrace symbolization. Please drop -rdynamic here too, as in the first
patch. The '=' to '+=' change is good, keep that.

Thanks.

--
tejun
