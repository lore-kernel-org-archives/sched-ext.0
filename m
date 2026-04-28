Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35F29B781
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403618; cv=none; b=Oi0cSZ9xEy6PIFgFxJISoDZIYQvR9osQfpT7KZSkArs6fizTfd7LGrUkCGkg4mBbzkE/fjWzuz+4kALky366hZk3Lw/diYXzi8A5n8zBMK9BG8VobHJeVIs36v4vyCQ9fYLMXmI+bR9FOPVTgKiCwNO84wtjlZS24pqHVNHZTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403618; c=relaxed/simple;
	bh=cYuR6X5Yh18kXwR6zGS6XnPvwHVB+ucPtarHJIH0BK4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SFPJ7/aBRWewwTs9Rznv7WNvxDZRQoggPk3pWKH3q7GdDttd1uZA+D4BbN9jHiqmZWtPt+5seXx+DBnspv2ZB5Byg0HmVWU4EeNXVnyr7r2NmN6VfArhxxqOF/VN2ljCGSD1kfMo3+ovKejrk5bDe92903RSvxxOeaU2ogv3HMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/o7j9hT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/o7j9hT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515FC2BCAF;
	Tue, 28 Apr 2026 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777403618;
	bh=cYuR6X5Yh18kXwR6zGS6XnPvwHVB+ucPtarHJIH0BK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/o7j9hTZBEGQ6dacOH19MNrz7S7S4n/hIepMpdcDnM973uGQBmsGhnPlThEowHod
	 YNCnZghNaQyrfWCcG3OBXabtKw4chMfWgJd2z8RO8ZaPY3aBsCK4itA3sGZYeUi7Td
	 I7S78zDJuyR/2ReKsRkMLbaHZRyv7ZBUVFpDr0ex3xWHfJIr0oUS3mV4xbmCw/fHjs
	 ClADRASJymXGcpawGcxL6elaQzCvwKVcxRTDMBY/qWGjR0x/Cp26tupYEynnBi2tt8
	 P9CRhSqnHld6NnI5XlWf5BJoy2/GJliB7ED35ALUFFnz2Jz3xR0gYHDYf/xkIdEocK
	 q+KqO4kEqunwg==
Date: Tue, 28 Apr 2026 09:13:37 -1000
Message-ID: <08619667d02d2c84e99d07a8adead6ee@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix scx_flush_disable_work() UAF race
In-Reply-To: <20260428173614.65965-1-yphbchou0911@gmail.com>
References: <20260428173614.65965-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Cheng-Yang Chou (1):
>   sched_ext: Fix scx_flush_disable_work() UAF race

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
