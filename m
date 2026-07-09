Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676C3EBF07;
	Thu,  9 Jul 2026 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636128; cv=none; b=tTGtDMCd+bg470TlrA8SOIUpiBjZMapxCOzDk5dTFFk0mzpKXuTeEoKHNvbB1RTeUTH6LwRn9iU4a0M99q7uMzmhKIbNlQd9It6klfN9o32xtBQ4TLDF5hVzQHJVfw9F0A079m+4n3ABiihfquR0dlR6vCp/f11ZSxz3FXBVO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636128; c=relaxed/simple;
	bh=w4NvV1MWMdr6WDf28H/lK6iUgSR0+Z+tfOYtD7T6hlk=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=n7OChdw8nPlHmhtVyFuY6kgRxn/tIVm9P9kkI+gqSlS6HSblcTlcTnngoEn7hyI/UCDQ0rnxNI9iK3B48pqwItiBBGD9IjdC0eHZaoU+loAQ1+HdqP+Tpj/wwj560qQGIG1DUiyWdFtsnP76JGVSZP9m4He9xwEtfsLjCbMZi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjqdQTMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjqdQTMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E911F00A3A;
	Thu,  9 Jul 2026 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636125;
	bh=j2Gl0yFFNgs0l5uOtV9Xuk1U+mOnl6rP7PRBfUVgXYc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hjqdQTMeRky4S/qAwOW2d4JTO27S4wJA8mBMjnDNtE5eQTXRwpp61uL8hL7Iu/LtC
	 CJdUcSoNPvcLyRB/WpYxmcpaRFpDuwQ9VPEdvKWgH497s4Obf8ehJjkdnffasaKdpp
	 lk8cMOqouggnf9EH57/zkgG7t9R4wvTWoVruI7Hnzycs5pax7DBkEdX122L+H2KvYm
	 JgYxhcDi3UZqeTy6+kE0ZRp+X+4VMHCl4cKd9VGNFtY4kv7CNkq9JAvJ7GC2k+CQSN
	 gldhuANOc39UkAlmUfvG7qZR/HuTbOTke0nJuO1KKVSC5slhWDm3uhHyogjmvlBscQ
	 vExfiNTcEyFVA==
Date: Thu, 09 Jul 2026 12:28:44 -1000
Message-ID: <1cc6b2b7c58f091d221535d826720f53@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220009.E27C81F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-33-tj@kernel.org> <20260708220009.E27C81F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 32/40] sched_ext: Add the SCX_CAP_ENQ cap
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:00:09 +0000, sashiko-bot@kernel.org wrote:
> - [High] Tasks with carried-in IMMED state are spuriously rejected
> during internal movements (like RESTORE) if the scheduler lacks
> SCX_CAP_ENQ.

Correct - an in-place RESTORE requeue of a running task re-runs cid
admission requiring SCX_CAP_ENQ while the enqueue carries no
SCX_ENQ_IMMED, so a sub holding only ENQ_IMMED bounces a task it's
already running. The restore isn't a real scheduling event
(set_next_task_scx() follows immediately) and shouldn't re-run admission
at all. Fixed in v5: the restore path marks the enqueue with an internal
IGNORE_CAPS flag which scx_caps_for_enq() maps to no required caps, split
out as a prep patch.

Thanks.

-- 
tejun
