Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE03AA4FE;
	Wed, 13 May 2026 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700227; cv=none; b=fk3bgTsvD7MXzRMyylx1Co5TQjutDWKNg7v5X5WC9xviZU5CSGRzlsEgGu9dKb289NvJ+2aNUZZy+8L05WqdbXGbgo4FBFL0jyUhIlHJy+cjpwv8XQpUQVD3UGUASJg5q/TbKcPdInBD+fLpxTVEutr2/UHUdWgKLY2+UgqhD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700227; c=relaxed/simple;
	bh=67Je7zEuFtffVUcrEDzeu8wDk1hKt/NZaWMiS/uWggk=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=Lu+aLN63jDNMf5a/rxmnvDHtrKEtsdnxX5OwFv2fzoqTNfKqHRKBw0TOwi9WIGNtkxGZb+0Y8Md2XHOuYnf91RT+24q/XnVgMfydOuB5R4dhBNmuHLvBCSrC5d56aYXz/Sl33zAIrk/+YAaM1+WsMEQygrHKKev4aIMgF/dYLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNP5RNhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNP5RNhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB28C19425;
	Wed, 13 May 2026 19:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700227;
	bh=67Je7zEuFtffVUcrEDzeu8wDk1hKt/NZaWMiS/uWggk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tNP5RNhTZxHPBDW6NZFjDiUkv9qNcO7hM2vXGXncCWMVtGwU7JFqvz9mmXh7V6gTU
	 NtY0WN8rUDGXntbGIDOA3FzwTa4Vx5ho/lKr+XISBNqj024JkNUiKaYKVODbVn8T6r
	 T5R3fxKzbc+n5ip0vsMlgrzRffchvEueBKeVcJrk6vP2v7EhbEATrcB+T5qN/9YQWF
	 yTXavDdD/YxmdGBrDSEiFXC4uesYyfYw0Vg3fUa3FU4dHYWXxRo4+EXL1V3ljQp11K
	 hplbA7hqOr7up0+YbpT0Q9f98nuIHThNWScDfhi4MNibsAVs4RfLIO/jw9TlMdZ/3E
	 J5yzgQZ1ixBNA==
Date: Wed, 13 May 2026 09:23:46 -1000
Message-ID: <ef3f239e50b9622fed3fdc90bd80aa9f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260513081731.15825-1-yphbchou0911@gmail.com>
References: <20260513081731.15825-1-yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap: Fix qa arena placement
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, May 13, 2026 at 04:17:11PM +0800, Cheng-Yang Chou wrote:
> tools/sched_ext: scx_qmap: Fix qa arena placement

Applied to sched_ext/for-7.2 with the Fixes: SHA replaced by
60a59eaca71b ("sched_ext: scx_qmap: move globals and cpu_ctx into a BPF
arena map"). The b986ae709b39 you referenced is a local-only commit on
one of my work branches; the corresponding public commit on for-7.2 is
60a59eaca71b. The arena conversion isn't on for-7.1-fixes, so the fix
lands on for-7.2 along with it.

Thanks.

--
tejun
