Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713830;
	b=Yuw0o7hvqzed2xpXMmKIgAntaX3dByfxq4Le0kB/wjkr6CO/os3JfEaPiA8+m7Fct8oe
	 E5Um+WZb+GbTQ/m6ANFJgnb6d1MpQYjK5svThUY2w+pBs8pV8sBe3ydfnMoXyoB93HBYn
	 dQXE1lTVidBVxT8LP6056wJaR94nOxJroFqw+2rXvb926qHPa05r/A1uXo3z564arMgs/
	 nbX18BvL37t25xDwCEn5doHD3hIvH3Kp2tew+gyHVak34i9PiEflkm78JtbSDJHMkb148
	 1VpVoTTUbHJl5e1upJTFMunk4P8SYT8k0SvjdMEchPh2ufGSbtHExh8tF/QwJ4xjQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cn6QXwaxPtdch10KPOR+oIekKdKvVwE0IAAsg2mm/GE=;
	b=qYDBcFvXHVkKgqnkcZRRK0j//vBdXDbUAcWVXpOik8dgRaY76oWB1qu3T3Yb/xYJYIvv
	 d8ydyTbP8fFtNWSuEPqglV/MbElTbaFJZyV2s7gJ632/3jCjJrwDvIXOBv/BNCqmxeg2Q
	 wR51nxv2ginaV5pc+JHP+Ua4Uei2w4BwKIR0Dv/1+bOZUQH6TxEsNId/DmTrEnRtL+Kfn
	 RH8i3bBw895DniPbjDJ5jdn/A0MmE4+g3iM3BifOnp32Bc/MUhQ1B01xY6Id5d/uEVsQA
	 2vX4AxeBSzGe85h3WszjEVKEj0QEaDLRPD25FFW7kf60LTgRT0DCQVEUIt6Qmum0jlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IUipfb/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915D606A319;
	Fri, 23 Oct 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUipfb/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BDD1F01825;
	Fri, 23 Oct 2026 00:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713829;
	bh=Cn6QXwaxPtdch10KPOR+oIekKdKvVwE0IAAsg2mm/GE=;
	h=From:To:Cc:Subject:Date;
	b=IUipfb/Ym/PRQX26C11q/QD8ksKvSuEzEQcvP8zW6mmwBxmBnP1747ZTZXuv9teTa
	 TkSTJWeM0XURDvRWiNAOOR5Db51cBzwmZ/Oa98PB58fCADMqLPApAJ6hxTkiN+dW4v
	 fRRR6erKMiZywdGa95Dx3zF2ZBwH2x989mWQKB9KGtA6SEnaddbrNEfmBemAxSNFUX
	 6yHUtWa67qDtrpI7rvGwh718vIaPyPCM86AA4Aftg+la4X8bJZhlSEQnss2sig7b5W
	 HU6PB6vmklqTo+L2THEa40bWCqWDn/uaOoCCid8CwGCWyiQ2QOqXYubN448UI2Mw7O
	 6zAIP55UertNg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.5] sched_ext: Regenerate the enum tables and drop scx_qmap's last compat lookup
Date: Thu, 22 Oct 2026 14:03:46 -1000
Message-ID: <20261023000348.2726436-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This follows up on the scx_qmap compat removal [1]. Andrea pointed out that
788b494fab1c ("sched_ext: scx_qmap: Drop the compat code") left one compat
lookup behind: the -B 0 case reads SCX_RESCUE_DISABLE with
__COMPAT_ENUM_OR_ZERO(). Userspace can read the enumerator only from BTF as
it is in the kernel-internal enum scx_consts, and the enum lookup tables
don't list it.

The first patch regenerates the two generated enum tables for the enums
added since the last regeneration. The second adds SCX_RESCUE_DISABLE to the
lookup tables and drops the compat lookup.

Verified that -B 0 disables rescue and that the default stays in place
without it.

[1] https://lore.kernel.org/r/20261019213221.2919481-1-tj@kernel.org

Based on sched_ext/for-7.5 (bbd3a3288035).

This patchset contains the following 2 patches.

 0001 sched_ext: Regenerate tools autogen enum headers
 0002 sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through the enum lookup tables

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git qmap-enums

diffstat follows. Thanks.

 tools/sched_ext/include/scx/enum_defs.autogen.h | 11 +++++++++++
 tools/sched_ext/include/scx/enums.autogen.bpf.h |  3 +++
 tools/sched_ext/include/scx/enums.autogen.h     |  1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h | 21 ++++++++++++++++-----
 tools/sched_ext/scx_qmap.c                      |  2 +-
 5 files changed, 32 insertions(+), 6 deletions(-)

--
tejun
